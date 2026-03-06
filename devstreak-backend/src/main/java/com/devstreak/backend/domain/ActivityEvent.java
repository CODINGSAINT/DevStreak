package com.devstreak.backend.domain;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "activity_events")
public class ActivityEvent {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false)
    private String eventType;

    @Column(columnDefinition = "TEXT")
    private String metadataJson;

    @Column(nullable = false)
    private LocalDateTime timestamp;

    public ActivityEvent() {
    }

    public ActivityEvent(User user, String eventType, String metadataJson, LocalDateTime timestamp) {
        this.user = user;
        this.eventType = eventType;
        this.metadataJson = metadataJson;
        this.timestamp = timestamp;
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public String getEventType() {
        return eventType;
    }

    public String getMetadataJson() {
        return metadataJson;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }
}
