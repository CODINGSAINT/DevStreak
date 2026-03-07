class SocialComment {
  final String author;
  final String text;

  const SocialComment({required this.author, required this.text});
}

class SocialActivity {
  final String actor;
  final String title;
  final String details;
  final DateTime timestamp;
  final List<SocialComment> comments;

  SocialActivity({
    required this.actor,
    required this.title,
    required this.details,
    required this.timestamp,
    List<SocialComment>? comments,
  }) : comments = comments ?? [];
}
