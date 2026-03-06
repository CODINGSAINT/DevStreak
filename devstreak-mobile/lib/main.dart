import 'package:flutter/material.dart';

import 'screens/activity_feed_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/dashboard_screen.dart';
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _api = ApiService();

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardScreen(apiService: _api),
      CalendarScreen(apiService: _api),
      ActivityFeedScreen(apiService: _api),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('DevStreak')),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Feed'),
        ],
      ),
    );
  }
}
