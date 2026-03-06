package com.devstreak.backend.domain;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "daily_stats", uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "day"}))
public class DailyStats {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(optional = false)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false)
    private LocalDate day;

    @Column(nullable = false)
    private boolean active;

    @Column(nullable = false)
    private int eventCount;

    public DailyStats() {
    }

    public DailyStats(User user, LocalDate day, boolean active, int eventCount) {
        this.user = user;
        this.day = day;
        this.active = active;
        this.eventCount = eventCount;
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public LocalDate getDay() {
        return day;
    }

    public boolean isActive() {
        return active;
    }

    public int getEventCount() {
        return eventCount;
    }

    public void markActive() {
        this.active = true;
        this.eventCount += 1;
    }
}
