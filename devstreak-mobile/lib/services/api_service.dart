import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/activity_feed_item.dart';
import '../models/calendar_day.dart';
import '../models/streak_stats.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';
  static const String userId = 'pallav';

  Future<StreakStats> fetchStreak() async {
    final response = await http.get(Uri.parse('$baseUrl/stats/streak?userId=$userId'));
    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    return StreakStats.fromJson(jsonBody);
  }

  Future<List<CalendarDay>> fetchCalendar({required int year, required int month}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stats/calendar?userId=$userId&year=$year&month=$month'),
    );
    final list = jsonDecode(response.body) as List<dynamic>;
    return list.map((e) => CalendarDay.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<ActivityFeedItem>> fetchActivityFeed() async {
    final response = await http.get(Uri.parse('$baseUrl/events?userId=$userId'));
    final list = jsonDecode(response.body) as List<dynamic>;
    return list
        .map((e) => ActivityFeedItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
