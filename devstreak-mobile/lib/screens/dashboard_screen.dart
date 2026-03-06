import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/streak_card.dart';

class DashboardScreen extends StatelessWidget {
  final ApiService apiService;

  const DashboardScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.fetchStreak(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final streak = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(12),
          children: [
            StreakCard(streakDays: streak.currentStreakDays),
            const SizedBox(height: 12),
            const Card(
              child: ListTile(
                title: Text('Today\'s Goal'),
                subtitle: Text('At least one coding event to keep your streak alive.'),
              ),
            ),
          ],
        );
      },
    );
  }
}
