import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homeee',
          style: TextStyle(
              fontSize: 25, color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
    );
  }
}
