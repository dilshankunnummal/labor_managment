import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:labor_managment/constants/colors.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({Key? key}) : super(key: key);

  @override
  _ServantDetailsPageState createState() => _ServantDetailsPageState();
}

class _ServantDetailsPageState extends State<WorkerHome> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String jobType = '';
  int experience = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servant Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: black)),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: secondaryColor,
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: black),
                  image: const DecorationImage(
                    image: AssetImage('assets/default_profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: black,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(Icons.email, color: ash),
                        const SizedBox(width: 10),
                        Text(
                          email,
                          style: const TextStyle(fontSize: 17, color: black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.work, color: ash),
                        const SizedBox(width: 10),
                        Text(
                          jobType,
                          style: const TextStyle(fontSize: 17, color: black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.timer, color: ash),
                        const SizedBox(width: 10),
                        Text(
                          '$experience years of experience',
                          style: const TextStyle(fontSize: 17, color: black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the editing page.
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditServantPage(), // Pass the necessary data to the editing page.
                //   ),
                // );
              },
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                foregroundColor: primaryColor,
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
