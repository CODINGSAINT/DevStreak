class StreakStats {
  final String userId;
  final int currentStreakDays;

  StreakStats({required this.userId, required this.currentStreakDays});

  factory StreakStats.fromJson(Map<String, dynamic> json) {
    return StreakStats(
      userId: json['userId'] as String,
      currentStreakDays: json['currentStreakDays'] as int,
    );
  }
}
