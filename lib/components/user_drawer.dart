import 'package:flutter/material.dart';
import 'package:labor_managment/components/round_image_widget.dart';
import 'package:labor_managment/constants/colors.dart';

class DrawerUser extends StatelessWidget {
  const DrawerUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 45.0),

            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            //user details in menu
            const SizedBox(height: 15.0),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('User Details'),
              onTap: () {},
            ),
            const SizedBox(height: 15.0),
            // exit option in menu
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {},
            ),
            // about in in menu
            const SizedBox(height: 15.0),
            ListTile(
              leading: Icon(Icons.warning_amber_outlined),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            //logout
            const SizedBox(height: 15.0),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Navigator.pushNamed(context , '/roleSelection');
              },
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
