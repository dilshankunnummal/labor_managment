import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/widget/button.dart';
import 'package:labor_managment/widget/textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerLogin extends StatefulWidget {
  const WorkerLogin({super.key});

  @override
  State<WorkerLogin> createState() => _WorkerLoginState();
}

class _WorkerLoginState extends State<WorkerLogin> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveAuthCredentialsWorker(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthWorker', value);
  }

  Future<bool> checkWorkerExists(String email) async {
    try {
      CollectionReference workers = _firestore.collection('workers');
      QuerySnapshot querySnapshot =
          await workers.where('email', isEqualTo: email).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking worker existence: $e');
      return false;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = emailTextController.text;
      String password = passwordTextController.text;

      bool workerExists = await checkWorkerExists(email);

      if (workerExists) {
        User? user = await signInWithEmailAndPassword(email, password);
        if (user != null) {
          print('Signed in successfully.');
          // Navigate to the worker dashboard or home screen
          Navigator.pushNamedAndRemoveUntil(
              context, '/workerdashboard', (route) => false);
          _showSnackbar('Signed in successfully., Welcome....');
          _saveAuthCredentialsWorker(true); // Update with your actual route
        } else {
          _showSnackbar('Login failed. Please check your credentials.');
        }
      } else {
        _showSnackbar('User does not exist.');
      }
    }
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 48),
                        CustomTextField(
                          labelText: 'Enter Email',
                          prefixIcon: Icons.mail_outline,
                          controller: emailTextController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          labelText: 'Enter Password',
                          prefixIcon: Icons.vpn_key,
                          controller: passwordTextController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                          onPressed: _login,
                          buttonText: 'Login',
                        ),
                        const SizedBox(height: 34.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account yet ?",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/workerRegistration');
                              },
                              child: const Text(
                                'Create',
                                style: TextStyle(
                                    color: blue, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
