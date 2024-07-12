import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Delay for 2 seconds
    await Future.delayed(Duration(seconds: 3));

    // Navigate to role selection page
    Navigator.pushReplacementNamed(context, '/roleSelection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Job Junction',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            SizedBox(height: 32),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ash),
            ),
          ],
        ),
      ),
    );
  }
}
