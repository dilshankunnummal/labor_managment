import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;

  CustomTextField(
      {required this.labelText,
      required this.prefixIcon,
      required TextEditingController controller,
      required bool obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: primaryColor),
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
    );
  }
}
