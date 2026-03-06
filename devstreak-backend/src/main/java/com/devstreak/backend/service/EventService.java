package com.devstreak.backend.service;

import com.devstreak.backend.domain.ActivityEvent;
import com.devstreak.backend.domain.DailyStats;
import com.devstreak.backend.domain.User;
import com.devstreak.backend.dto.EventRequest;
import com.devstreak.backend.repository.ActivityEventRepository;
import com.devstreak.backend.repository.DailyStatsRepository;
import com.devstreak.backend.repository.UserRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
public class EventService {

    private final UserRepository userRepository;
    private final ActivityEventRepository activityEventRepository;
    private final DailyStatsRepository dailyStatsRepository;
    private final ObjectMapper objectMapper;

    public EventService(UserRepository userRepository,
                        ActivityEventRepository activityEventRepository,
                        DailyStatsRepository dailyStatsRepository,
                        ObjectMapper objectMapper) {
        this.userRepository = userRepository;
        this.activityEventRepository = activityEventRepository;
        this.dailyStatsRepository = dailyStatsRepository;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public void ingest(EventRequest request) {
        User user = userRepository.findById(request.userId())
                .orElseGet(() -> userRepository.save(new User(request.userId(), request.userId())));

        String metadata = "{}";
        try {
            metadata = objectMapper.writeValueAsString(request.metadata());
        } catch (JsonProcessingException ignored) {
        }

        activityEventRepository.save(new ActivityEvent(
                user,
                request.eventType(),
                metadata,
                request.timestamp()
        ));

        LocalDate day = request.timestamp().toLocalDate();
        DailyStats stats = dailyStatsRepository.findByUserAndDay(user, day)
                .orElseGet(() -> new DailyStats(user, day, false, 0));
        stats.markActive();
        dailyStatsRepository.save(stats);
    }
}
