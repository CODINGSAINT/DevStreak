class CalendarDay {
  final DateTime day;
  final bool active;
  final int eventCount;

  CalendarDay({required this.day, required this.active, required this.eventCount});

  factory CalendarDay.fromJson(Map<String, dynamic> json) {
    return CalendarDay(
      day: DateTime.parse(json['day'] as String),
      active: json['active'] as bool,
      eventCount: json['eventCount'] as int,
    );
  }
}
