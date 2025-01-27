import 'package:flutter/material.dart';

import '../../Pages/cancel_task_page.dart';
import '../../Pages/complete_task_page.dart';
import '../../Pages/home_page.dart';
import '../../Pages/progress_page.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  static const String name = '/dashboard';

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectIndex = 0;
  final List<Widget> _pageList = const [
    HomePage(),
    ProgressPage(),
    CancelTaskPage(),
    CompleteTaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_selectIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectIndex,
          onDestinationSelected: (int index) {
            _selectIndex = index;
            setState(() {});
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.dashboard),
              icon: Icon(Icons.dashboard_customize),
              label: 'Dashboard',
            ),
            NavigationDestination(icon: Icon(Icons.cached), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.cancel), label: 'Cancel'),
            NavigationDestination(
                icon: Icon(Icons.recent_actors), label: 'Complete'),
          ]),
    );
  }
}
