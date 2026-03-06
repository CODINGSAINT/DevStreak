# devstreak-mobile

Flutter mobile app for DevStreak visualizations.

## Folder Structure

```text
devstreak-mobile/
├── pubspec.yaml
├── README.md
└── lib/
    ├── main.dart
    ├── models/
    │   ├── streak_stats.dart
    │   ├── calendar_day.dart
    │   └── activity_feed_item.dart
    ├── services/api_service.dart
    ├── screens/
    │   ├── dashboard_screen.dart
    │   ├── calendar_screen.dart
    │   └── activity_feed_screen.dart
    └── widgets/streak_card.dart
```

## Build / Install dependencies

```bash
cd devstreak-mobile
flutter pub get
```

## Run

```bash
flutter run
```

Set backend URL in `lib/services/api_service.dart` if needed.
