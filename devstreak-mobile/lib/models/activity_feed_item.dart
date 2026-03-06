class ActivityFeedItem {
  final int id;
  final String eventType;
  final String timestamp;
  final String metadata;

  ActivityFeedItem({
    required this.id,
    required this.eventType,
    required this.timestamp,
    required this.metadata,
  });

  factory ActivityFeedItem.fromJson(Map<String, dynamic> json) {
    return ActivityFeedItem(
      id: json['id'] as int,
      eventType: json['eventType'] as String,
      timestamp: json['timestamp'] as String,
      metadata: json['metadata'] as String,
    );
  }
}
