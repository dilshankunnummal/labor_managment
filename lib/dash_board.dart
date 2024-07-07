import 'package:flutter/material.dart';
import 'package:labor_managment/widget/button.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userLogin');
              },
              buttonText: '/User'),
          CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/workerLogin');
              },
              buttonText: 'Staff')
        ],
      ),
    );
  }
}
