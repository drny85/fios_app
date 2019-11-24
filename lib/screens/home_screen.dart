import 'package:fios/screens/managers/managers_screen.dart';
import 'package:fios/screens/notes/notes_screen.dart';
import 'package:fios/screens/profile_screen.dart';

import 'package:fios/screens/referrals/referrals_screen.dart';
import 'package:fios/screens/today/today_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  List<Widget> _pages = [
    ReferralsScreen(),
    TodayScreen(),
    NotesScreen(),
    ManagersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentTab],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentTab,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Referrals'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Today'),
            icon: Icon(Icons.calendar_today),
          ),
          BottomNavigationBarItem(
            title: Text('Notes'),
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            title: Text('Managers'),
            icon: Icon(Icons.group_work),
          ),
          BottomNavigationBarItem(
            title: Text('Me'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
