import 'package:flutter/material.dart';

class profileButton extends StatelessWidget{
  final Function()? onTap;
  final String buttonText;
  final IconData iconData;
  const profileButton({
    super.key, 
    required this.onTap,
    required this.buttonText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Icon(
              Icons.chevron_right,
            )
          ],
        ),
      ),
    );
  }
}