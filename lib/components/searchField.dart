import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class MySearchField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;

  const MySearchField({
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
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: OneIDColor.grey)),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.search,
          color: OneIDColor.darkGrey,
          size: 24,
        ),
        label:
            Text(labelText, style: const TextStyle(color: OneIDColor.darkGrey)),
        hintStyle: const TextStyle(color: OneIDColor.grey),
      ),
    );
  }
}