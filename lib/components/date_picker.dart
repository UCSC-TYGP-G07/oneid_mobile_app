import 'package:flutter/material.dart';

class MyDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const MyDatePicker({
    required this.controller,
    required this.labelText,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year),
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: IgnorePointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),
            ),
            filled: true,
            label: Text(
              labelText,
              style: TextStyle(color: Colors.grey),
            ),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
