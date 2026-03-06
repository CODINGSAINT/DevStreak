package com.devstreak.backend.dto;

import java.time.LocalDate;

public record DailyStatsResponse(String userId, LocalDate day, boolean active, int eventCount) {
}
