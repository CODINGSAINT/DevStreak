package com.devstreak.backend.repository;

import com.devstreak.backend.domain.ActivityEvent;
import com.devstreak.backend.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ActivityEventRepository extends JpaRepository<ActivityEvent, Long> {
    List<ActivityEvent> findTop50ByUserOrderByTimestampDesc(User user);
}
