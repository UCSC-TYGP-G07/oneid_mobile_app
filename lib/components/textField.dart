import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
            color: OneIDColor.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 16),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: OneIDColor.grey)),
        filled: true,
        label:
            Text(labelText, style: const TextStyle(color: OneIDColor.darkGrey)),
        hintStyle: const TextStyle(color: OneIDColor.grey),
      ),
    );
  }
}
