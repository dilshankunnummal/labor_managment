import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labor_managment/components/user_drawer.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/widget/button.dart';
import 'package:labor_managment/widget/textfield.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.pushNamed(
          context, '/userHome'); // Redirect to home page after login
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "An error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 48),
                        CustomTextField(
                          labelText: 'Enter Email',
                          prefixIcon: Icons.mail_outline,
                          controller: emailTextController,
                          obscureText: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          labelText: 'Enter Password',
                          prefixIcon: Icons.vpn_key,
                          controller: passwordTextController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        CustomElevatedButton(
                            onPressed: () {
                              signIn(emailTextController.text,
                                  passwordTextController.text);
                            },
                            buttonText: 'Login'),
                        const SizedBox(height: 34.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Dont have an accout yet ?'),
                            SizedBox(width: 6),
                            GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/userRegistration');
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(color: blue),
                                ))
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
