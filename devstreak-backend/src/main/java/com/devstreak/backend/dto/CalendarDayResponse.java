package com.devstreak.backend.dto;

import java.time.LocalDate;

public record CalendarDayResponse(LocalDate day, boolean active, int eventCount) {
}
