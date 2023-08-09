import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class SecondaryButton extends StatelessWidget{
  final Function()? onTap;
  final String buttonText;
  final double width;

  const SecondaryButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.width = double.infinity
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
        width: double.infinity,
        child:OutlinedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                color: OneIDColor.primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(buttonText,
                style: const TextStyle(
                  color: OneIDColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
            )
        )
    );
  }
}