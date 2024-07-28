import 'package:flutter/material.dart';
import 'package:labor_managment/admin/admin_home.dart';
import 'package:labor_managment/admin/staff_management.dart';
import 'package:labor_managment/admin/user_managment.dart';
import 'package:labor_managment/constants/colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var _currentIndex = 0;

  final List<Widget> _bodyPages = const <Widget>[
    AdminHome(),
    UserManagementPage(),
    StaffManagementPage()
    // Add more pages if needed
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      activeIcon: Icon(Icons.person),
      label: 'Users',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.work),
      activeIcon: Icon(Icons.work),
      label: 'Staff',
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
