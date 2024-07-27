// import 'package:flutter/material.dart';

// class AdminDashboard extends StatefulWidget {
//   const AdminDashboard({super.key});

//   @override
//   State<AdminDashboard> createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:flutter/material.dart';
import 'package:labor_managment/admin/admin_home.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/worker/worker_history.dart';
import 'package:labor_managment/worker/worker_home.dart';
import 'package:labor_managment/worker/worker_profile.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<AdminDashboard> {
  var _currentIndex = 0;

  final _bodyPages = const <Widget>[
    AdminHome(),
  ];

  final _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.person_outlined),
    //   activeIcon: Icon(Icons.person_outline),
    //   label: 'Profile',
    // ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.history),
    //   activeIcon: Icon(Icons.history),
    //   label: 'History',
    // ),
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
