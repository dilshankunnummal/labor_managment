import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';

class EditWorkerPage extends StatefulWidget {
  const EditWorkerPage({Key? key}) : super(key: key);

  @override
  _EditWorkerPageState createState() => _EditWorkerPageState();
}

class _EditWorkerPageState extends State<EditWorkerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String currentUserUid = user.uid;
          await FirebaseFirestore.instance
              .collection('workers')
              .doc(currentUserUid)
              .update({
            'userName': _userNameController.text,
            'email': _emailController.text,
            'experience': int.tryParse(_experienceController.text) ?? 0,
          });

          // Pass updated data back
          Navigator.pop(context, {
            'userName': _userNameController.text,
            'email': _emailController.text,
            'experience': int.tryParse(_experienceController.text) ?? 0,
          });
        }
      } catch (e) {
        print('Error updating worker details: $e');
      }
    }
  }

  Future<void> _fetchCurrentDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot workerSnapshot = await FirebaseFirestore.instance
          .collection('workers')
          .doc(user.uid)
          .get();
      if (workerSnapshot.exists) {
        var data = workerSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _userNameController.text = data['userName'] ?? '';
          _emailController.text = data['email'] ?? '';
          _experienceController.text = data['experience']?.toString() ?? '0';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrentDetails();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Worker Profile',
          style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 64),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  // labelText: 'Username',
                  // labelStyle: const TextStyle(color: secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  // labelText: 'Email',
                  // labelStyle: const TextStyle(color: secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _experienceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // labelText: 'Experience (years)',
                  // labelStyle: const TextStyle(color: secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: secondaryColor),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your experience';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text(
                  'Save ',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: primaryColor,
                  backgroundColor: secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
