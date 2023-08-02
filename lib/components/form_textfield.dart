import 'package:flutter/material.dart';

class textField extends StatelessWidget{
  final String hintText;

  const textField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}