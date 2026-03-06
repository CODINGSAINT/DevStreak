import 'package:flutter/material.dart';

import '../models/calendar_day.dart';
import '../services/api_service.dart';

class CalendarScreen extends StatelessWidget {
  final ApiService apiService;

  const CalendarScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return FutureBuilder<List<CalendarDay>>(
      future: apiService.fetchCalendar(year: now.year, month: now.month),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final days = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('M T W T F S S', style: TextStyle(letterSpacing: 2)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: days
                  .map(
                    (d) => Text(
                      d.active ? '●' : '○',
                      style: TextStyle(
                        color: d.active ? Colors.green : Colors.grey,
                        fontSize: 22,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
