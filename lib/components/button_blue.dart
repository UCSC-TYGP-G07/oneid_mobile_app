import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget{
  final Function()? onTap;
  final String buttonText;

  const BlueButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Container(
          decoration: BoxDecoration(
            //color: Colors.black,
            color: const Color(0xFF27187E),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFF27187E),
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.all(20),
          // margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}