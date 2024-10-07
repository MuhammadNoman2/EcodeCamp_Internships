// lib/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'task_list_screen.dart';
import 'today_tasks_screen.dart';
import 'upcoming_tasks_screen.dart';
import 'completed_tasks_screen.dart';
import 'add_edit_task_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    TaskListScreen(),
    TodayTasksScreen(),
    UpcomingTasksScreen(),
    CompletedTasksScreen(),
  ];

  final List<String> _titles = [
    'All Tasks',
    'Today\'s Tasks',
    'Upcoming Tasks',
    'Completed Tasks',
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Handle the middle "add task" button tap
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddEditTaskScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index < 2 ? index : index - 1; // Adjust index for screens
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Make body go behind the app bar
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -1),
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,  // Set to transparent to keep gradient
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex < 2 ? _selectedIndex : _selectedIndex + 1,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: 'Today',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 40,
                color: Colors.white60, // Center "add task" button
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Upcoming',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'Completed',
            ),
          ],
        ),
      ),
    );
  }
}
