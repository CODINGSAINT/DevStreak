package com.devstreak.backend.service;

import com.devstreak.backend.domain.DailyStats;
import com.devstreak.backend.domain.User;
import com.devstreak.backend.dto.CalendarDayResponse;
import com.devstreak.backend.dto.DailyStatsResponse;
import com.devstreak.backend.dto.StreakResponse;
import com.devstreak.backend.repository.DailyStatsRepository;
import com.devstreak.backend.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Collections;
import java.util.List;

@Service
public class StatsService {

    private final UserRepository userRepository;
    private final DailyStatsRepository dailyStatsRepository;

    public StatsService(UserRepository userRepository, DailyStatsRepository dailyStatsRepository) {
        this.userRepository = userRepository;
        this.dailyStatsRepository = dailyStatsRepository;
    }

    public StreakResponse currentStreak(String userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return new StreakResponse(userId, 0);
        }

        List<DailyStats> days = dailyStatsRepository.findByUserAndDayLessThanEqualOrderByDayDesc(user, LocalDate.now());
        int streak = 0;
        LocalDate expected = LocalDate.now();
        for (DailyStats d : days) {
            if (!d.isActive()) continue;
            if (d.getDay().isEqual(expected)) {
                streak++;
                expected = expected.minusDays(1);
            } else if (d.getDay().isBefore(expected)) {
                break;
            }
        }
        return new StreakResponse(userId, streak);
    }

    public DailyStatsResponse daily(String userId, LocalDate day) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return new DailyStatsResponse(userId, day, false, 0);
        }

        return dailyStatsRepository.findByUserAndDay(user, day)
                .map(d -> new DailyStatsResponse(userId, d.getDay(), d.isActive(), d.getEventCount()))
                .orElseGet(() -> new DailyStatsResponse(userId, day, false, 0));
    }

    public List<CalendarDayResponse> calendar(String userId, int year, int month) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return Collections.emptyList();
        }

        YearMonth ym = YearMonth.of(year, month);
        LocalDate start = ym.atDay(1);
        LocalDate end = ym.atEndOfMonth();

        return dailyStatsRepository.findByUserAndDayBetweenOrderByDayAsc(user, start, end)
                .stream()
                .map(d -> new CalendarDayResponse(d.getDay(), d.isActive(), d.getEventCount()))
                .toList();
    }
}
