package com.devstreak.backend.controller;

import com.devstreak.backend.domain.ActivityEvent;
import com.devstreak.backend.domain.User;
import com.devstreak.backend.dto.EventRequest;
import com.devstreak.backend.repository.ActivityEventRepository;
import com.devstreak.backend.repository.UserRepository;
import com.devstreak.backend.service.EventService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping
public class EventController {

    private final EventService eventService;
    private final UserRepository userRepository;
    private final ActivityEventRepository activityEventRepository;

    public EventController(EventService eventService,
                           UserRepository userRepository,
                           ActivityEventRepository activityEventRepository) {
        this.eventService = eventService;
        this.userRepository = userRepository;
        this.activityEventRepository = activityEventRepository;
    }

    @PostMapping("/events")
    public ResponseEntity<Void> ingest(@Valid @RequestBody EventRequest request) {
        eventService.ingest(request);
        return ResponseEntity.accepted().build();
    }

    @GetMapping("/events")
    public List<Map<String, Object>> feed(@RequestParam String userId) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return List.of();
        }

        return activityEventRepository.findTop50ByUserOrderByTimestampDesc(user)
                .stream()
                .map(this::toFeedItem)
                .toList();
    }

    private Map<String, Object> toFeedItem(ActivityEvent event) {
        return Map.of(
                "id", event.getId(),
                "eventType", event.getEventType(),
                "metadata", event.getMetadataJson(),
                "timestamp", event.getTimestamp().toString()
        );
    }
}
