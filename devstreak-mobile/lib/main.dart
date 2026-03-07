import 'package:flutter/material.dart';

import 'models/social_activity.dart';
import 'models/target_goal.dart';
import 'screens/activity_feed_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/target_screen.dart';
import 'screens/users_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(const DevStreakApp());
}

class DevStreakApp extends StatelessWidget {
  const DevStreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevStreak',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  String? _currentUser;

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return LoginScreen(onLogin: (username) => setState(() => _currentUser = username));
    }

    return HomeScreen(currentUser: _currentUser!);
  }
}

class HomeScreen extends StatefulWidget {
  final String currentUser;

  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _api = ApiService();

  late final List<String> _users = [widget.currentUser, 'maya', 'alex'];
  final Set<String> _following = {'maya'};
  final List<TargetGoal> _targets = [
    const TargetGoal(
      title: 'YouTube channel posts',
      category: 'Content',
      frequency: TargetFrequency.weekly,
      count: 3,
      tags: ['youtube', 'learning'],
      icon: Icons.play_circle,
    ),
    const TargetGoal(
      title: 'LeetCode daily',
      category: 'Coding Practice',
      frequency: TargetFrequency.daily,
      tags: ['leetcode', 'dsa'],
      icon: Icons.code,
    ),
  ];

  late final List<SocialActivity> _activities = [
    SocialActivity(
      actor: widget.currentUser,
      title: 'Completed LeetCode target',
      details: 'Solved 1 medium problem today.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      comments: const [SocialComment(author: 'maya', text: 'Nice consistency!')],
    ),
    SocialActivity(
      actor: 'maya',
      title: 'Posted 1 YouTube video',
      details: 'System design episode published.',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    SocialActivity(
      actor: 'alex',
      title: 'Finished manual task',
      details: 'Read 20 pages of engineering handbook.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(apiService: _api),
      TargetScreen(
        targets: _targets,
        onAddTarget: (target) => setState(() {
          _targets.add(target);
          _activities.insert(
            0,
            SocialActivity(
              actor: widget.currentUser,
              title: 'Added a new target',
              details: '${target.title} (${target.frequencyLabel})',
              timestamp: DateTime.now(),
            ),
          );
        }),
      ),
      ActivityFeedScreen(
        currentUser: widget.currentUser,
        following: _following,
        activities: _activities,
        onAddComment: (index, text) => setState(() {
          _activities[index].comments
              .add(SocialComment(author: widget.currentUser, text: text));
        }),
      ),
      CalendarScreen(apiService: _api),
      UsersScreen(
        users: _users.where((u) => u != widget.currentUser).toList(),
        following: _following,
        onAddUser: (username) => setState(() {
          if (!_users.contains(username)) {
            _users.add(username);
            _activities.insert(
              0,
              SocialActivity(
                actor: username,
                title: 'Joined DevStreak',
                details: 'New user is ready to track goals.',
                timestamp: DateTime.now(),
              ),
            );
          }
        }),
        onToggleFollow: (username) => setState(() {
          if (_following.contains(username)) {
            _following.remove(username);
          } else {
            _following.add(username);
          }
        }),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('DevStreak • ${widget.currentUser}')),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.flag), label: 'Targets'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Feed'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.person_add), label: 'Users'),
        ],
      ),
    );
  }
}
