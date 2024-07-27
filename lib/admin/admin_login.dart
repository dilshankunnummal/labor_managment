import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/widget/button.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      SnackBar(content: Text('Login Success'));
      print('Login successful: ${userCredential.user}');
      _saveAuthCredentialsAdmin(true);

      Navigator.pushNamed(context, '/adminDashboard');
    } catch (e) {
      SnackBar(content: Text('Login Failed'));
      print('Login failed: $e');
    }
  }

  void _saveAuthCredentialsAdmin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthAdmin', value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  const Text(
                    'Login As',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Admin',
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 80,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: ash),
                      decoration: const InputDecoration(
                        labelText: 'Enter Email',
                        labelStyle: TextStyle(color: ash),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ash,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ash, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ash, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ash, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 010),
                  SizedBox(
                    height: 80,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Enter Password',
                        labelStyle: TextStyle(color: ash),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: ash,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ash, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ash, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ash, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                          buttonText: 'Login'),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
