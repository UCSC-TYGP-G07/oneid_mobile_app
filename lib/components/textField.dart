import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
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
