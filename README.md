# DevStreak

DevStreak is a **"Strava for Developers"** MVP with three components:

1. **Windows Local Agent (Python)**: detects coding activity and emits events.
2. **Backend API (Spring Boot + PostgreSQL)**: stores events and computes streak analytics.
3. **Mobile App (Flutter)**: displays dashboard, calendar, and activity feed.

## 1) System Architecture

```text
+------------------------+      HTTPS       +------------------------------+      JSON APIs      +------------------+
| Windows Local Agent    | ---------------> | Spring Boot Backend          | <------------------ | Flutter Mobile   |
| - Process polling      |  POST /events    | - Event ingestion            |  /stats/*, /events  | - Dashboard      |
| - Git commit watcher   |                  | - Daily aggregation          |                     | - Calendar       |
| - LeetCode poller      |                  | - Streak calculation         |                     | - Activity feed  |
+------------------------+                  +------------------------------+                     +------------------+
                                                     |
                                                     v
                                             PostgreSQL Database
```

## 2) Repository Structure

```text
DevStreak/
├── devstreak-agent/
├── devstreak-backend/
└── devstreak-mobile/
```

Detailed per-project structure is documented inside each subproject README.

## 3) Starter Code

Starter code for all three projects has been scaffolded and wired together with matching API contracts.

## 4) How to Run

See each project README:

- `devstreak-agent/README.md`
- `devstreak-backend/README.md`
- `devstreak-mobile/README.md`

## 5) MVP in One Weekend

### Day 1 (Backend + Agent core)
- Bootstrap backend project and Postgres schema.
- Implement `POST /events` and streak stats endpoints.
- Implement local agent process and git watchers.

### Day 2 (Mobile + Integration)
- Build Flutter dashboard/calendar/feed.
- Integrate with backend APIs.
- Add local demo flow with one user (`pallav`) and verify streak updates.

This MVP tracks activity, marks active days, and computes consecutive streaks.
