

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/user/booking_history_page.dart';
import 'package:labor_managment/user/user_home.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<UserDashboardPage> {
  var _currentIndex = 0;

  final _bodyPages = const <Widget>[
    UserHome(),
    BookingHistoryPage()
  ];

  final _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.history_rounded),
      activeIcon: Icon(Icons.history_rounded),
      label: 'Bookings',
    ),

  ];

  void _onItemClick(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        items: _bottomNavBarItems,
        onTap: _onItemClick,

      ),
    );
  }
}
