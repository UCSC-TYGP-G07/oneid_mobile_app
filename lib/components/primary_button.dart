import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class PrimaryButton extends StatelessWidget{
  final Function()? onTap;
  final String buttonText;
  final double width;
  final Color color;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.width = double.infinity,
    this.color = OneIDColor.primaryColor
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
        width: double.infinity,
        child:ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
            )
        )
    );
  }
}