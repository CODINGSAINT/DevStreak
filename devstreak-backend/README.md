# devstreak-backend

Spring Boot backend for event ingestion and streak analytics.

## Folder Structure

```text
devstreak-backend/
├── pom.xml
├── README.md
├── src/main/resources/application.yml
└── src/main/java/com/devstreak/backend/
    ├── DevStreakBackendApplication.java
    ├── controller/
    ├── domain/
    ├── dto/
    ├── repository/
    └── service/
```

## Build

```bash
cd devstreak-backend
mvn clean package
```

## Run

```bash
mvn spring-boot:run
```

Configure DB with environment variables:

- `DB_URL` (default `jdbc:postgresql://localhost:5432/devstreak`)
- `DB_USERNAME` (default `postgres`)
- `DB_PASSWORD` (default `postgres`)

## APIs

- `POST /events`
- `GET /stats/streak?userId=pallav`
- `GET /stats/daily?userId=pallav&date=2026-03-06`
- `GET /stats/calendar?userId=pallav&year=2026&month=3`
- `GET /events?userId=pallav`
