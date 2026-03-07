import 'package:flutter/material.dart';

import '../models/social_activity.dart';

class ActivityFeedScreen extends StatefulWidget {
  final String currentUser;
  final Set<String> following;
  final List<SocialActivity> activities;
  final void Function(int index, String text) onAddComment;

  const ActivityFeedScreen({
    super.key,
    required this.currentUser,
    required this.following,
    required this.activities,
    required this.onAddComment,
  });

  @override
  State<ActivityFeedScreen> createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleActivities = widget.activities
        .asMap()
        .entries
        .where((entry) =>
            entry.value.actor == widget.currentUser || widget.following.contains(entry.value.actor))
        .toList();

    if (visibleActivities.isEmpty) {
      return const Center(child: Text('No activity yet from you or people you follow.'));
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: visibleActivities.map((entry) {
        final index = entry.key;
        final activity = entry.value;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.local_fire_department),
                  title: Text('${activity.actor} • ${activity.title}'),
                  subtitle: Text(activity.details),
                ),
                Text(activity.timestamp.toLocal().toString()),
                const Divider(),
                const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
                ...activity.comments.map(
                  (comment) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.comment, size: 18),
                    title: Text(comment.author),
                    subtitle: Text(comment.text),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(hintText: 'Write a comment'),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final text = _commentController.text.trim();
                        if (text.isEmpty) return;
                        widget.onAddComment(index, text);
                        _commentController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
