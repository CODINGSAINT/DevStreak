import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  final int streakDays;

  const StreakCard({super.key, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Streak', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('$streakDays days 🔥', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
