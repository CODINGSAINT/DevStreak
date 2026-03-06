import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ActivityFeedScreen extends StatelessWidget {
  final ApiService apiService;

  const ActivityFeedScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.fetchActivityFeed(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data!;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: const Icon(Icons.code),
              title: Text(item.eventType),
              subtitle: Text('${item.timestamp}\n${item.metadata}'),
              isThreeLine: true,
            );
          },
        );
      },
    );
  }
}
