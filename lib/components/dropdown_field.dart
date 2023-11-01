import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String? selectedItem;
  final String labelText;
  final Function(String?) onItemSelected;

  const MyDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.labelText,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      items: items,
      onChanged: onItemSelected,
      elevation: 0,
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
    );
  }
}
