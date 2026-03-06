package com.devstreak.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.Map;

public record EventRequest(
        @NotBlank String userId,
        @NotBlank String eventType,
        @NotNull Map<String, Object> metadata,
        @NotNull LocalDateTime timestamp
) {
}
