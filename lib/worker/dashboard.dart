import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/worker/accepted_booking.dart';
import 'package:labor_managment/worker/rejected_booking.dart';
import 'package:labor_managment/worker/worker_home.dart';
import 'package:labor_managment/worker/worker_profile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _currentIndex = 0;

  final _bodyPages = const <Widget>[
    WorkerHome(),

    RejectedBookings(),
    AcceptedBookings(),
    WorkerProfile(),
  ];

  final _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),

    const BottomNavigationBarItem(
      icon: Icon(Icons.cancel_outlined),
      activeIcon: Icon(Icons.cancel_outlined),
      label: 'Rejected',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.done_all),
      activeIcon: Icon(Icons.done_all),
      label: 'Accepted',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person_outline),
      label: 'Profile',
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
        selectedItemColor: secondaryColor,
        unselectedItemColor: ash,
      ),
    );
  }
}
