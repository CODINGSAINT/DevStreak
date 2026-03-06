package com.devstreak.backend.repository;

import com.devstreak.backend.domain.DailyStats;
import com.devstreak.backend.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface DailyStatsRepository extends JpaRepository<DailyStats, Long> {
    Optional<DailyStats> findByUserAndDay(User user, LocalDate day);
    List<DailyStats> findByUserAndDayBetweenOrderByDayAsc(User user, LocalDate start, LocalDate end);
    List<DailyStats> findByUserAndDayLessThanEqualOrderByDayDesc(User user, LocalDate day);
}
