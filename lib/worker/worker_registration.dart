import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/model/worker_model.dart';
import 'package:labor_managment/widget/button.dart';
import 'package:labor_managment/widget/textfield.dart';

class WorkerRegistration extends StatefulWidget {
  const WorkerRegistration({super.key});

  @override
  State<WorkerRegistration> createState() => _WorkerRegistrationState();
}

class _WorkerRegistrationState extends State<WorkerRegistration> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _experienceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  String? _selectedJobType;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Register With Your Details!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: CustomTextField(
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                      controller: _nameController,
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: CustomTextField(
                      labelText: 'Email',
                      prefixIcon: Icons.mail_outline,
                      controller: _emailController,
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: CustomTextField(
                      labelText: 'Password',
                      prefixIcon: Icons.vpn_key,
                      controller: _passwordController,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: SizedBox(
                      height: 56,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(color: ash),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedJobType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedJobType = newValue;
                            });
                          },
                          items: WorkerModel.jobTypes.map((jobType) {
                            return DropdownMenuItem<String>(
                              value: jobType,
                              child: Text(jobType),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.build),
                            border: InputBorder.none,
                            hintText: 'Job Type',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a job type';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child: CustomTextField(
                      labelText: 'Experience',
                      prefixIcon: Icons.work,
                      controller: _experienceController,
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: CustomElevatedButton(
                        onPressed: () {
                          signUp(
                            _emailController.text,
                            _nameController.text,
                            _passwordController.text,
                            _selectedJobType.toString(),
                            int.parse(_experienceController.text),
                          );
                        },
                        buttonText: 'Sign UP'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/workerLogin');
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String username, String password, String jobType,
      int experience) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          postDetailsToFirestore(
              email, username, password, jobType, experience);
        }).catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  Future<void> postDetailsToFirestore(
    String email,
    String username,
    String password,
    String jobType,
    int experience,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    WorkerModel workerModel = WorkerModel(
      uid: user!.uid,
      userName: username,
      email: user.email,
      password: password,
      jobType: jobType,
      experience: experience,
    );

    await firebaseFirestore
        .collection("workers")
        .doc(user.uid)
        .set(workerModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushNamed(context, '/workerHome');
  }
}
