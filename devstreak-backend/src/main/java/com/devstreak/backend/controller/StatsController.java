package com.devstreak.backend.controller;

import com.devstreak.backend.dto.CalendarDayResponse;
import com.devstreak.backend.dto.DailyStatsResponse;
import com.devstreak.backend.dto.StreakResponse;
import com.devstreak.backend.service.StatsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/stats")
public class StatsController {

    private final StatsService statsService;

    public StatsController(StatsService statsService) {
        this.statsService = statsService;
    }

    @GetMapping("/streak")
    public StreakResponse streak(@RequestParam String userId) {
        return statsService.currentStreak(userId);
    }

    @GetMapping("/daily")
    public DailyStatsResponse daily(@RequestParam String userId, @RequestParam LocalDate date) {
        return statsService.daily(userId, date);
    }

    @GetMapping("/calendar")
    public List<CalendarDayResponse> calendar(
            @RequestParam String userId,
            @RequestParam int year,
            @RequestParam int month
    ) {
        return statsService.calendar(userId, year, month);
    }
}
