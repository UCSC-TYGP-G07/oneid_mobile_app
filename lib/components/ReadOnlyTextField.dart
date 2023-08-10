import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class ReadOnlyTextField extends StatelessWidget {
  final String labelText;
  final String value;

  const ReadOnlyTextField({
    super.key,
    required this.labelText,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
          // suffixIcon: const Icon(Icons.arrow_drop_down),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: OneIDColor.grey)),
          filled: true,
          fillColor: Colors.white,
          label: Text(labelText,
              style: const TextStyle(
                  color: OneIDColor.primaryColor, fontSize: 18)),
          hintStyle: const TextStyle(color: OneIDColor.darkGrey),
          hintText: value),
    );
  }
}
