import 'package:flutter/material.dart';

enum TargetFrequency { daily, weekly, manual }

class TargetGoal {
  final String title;
  final String category;
  final TargetFrequency frequency;
  final int? count;
  final List<String> tags;
  final IconData icon;

  const TargetGoal({
    required this.title,
    required this.category,
    required this.frequency,
    required this.tags,
    required this.icon,
    this.count,
  });

  String get frequencyLabel {
    switch (frequency) {
      case TargetFrequency.daily:
        return 'Daily';
      case TargetFrequency.weekly:
        return 'Weekly';
      case TargetFrequency.manual:
        return 'Manual';
    }
  }
}
