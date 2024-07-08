import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator; // Add validator

  CustomTextField({
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Ensure controller is assigned
      obscureText: obscureText,
      style: TextStyle(color: ash),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: ash),
        iconColor: ash,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ash),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: validator,
    );
  }
}
