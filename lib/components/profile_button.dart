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
        decoration: BoxDecoration(
          //color: Colors.black,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  iconData,
                ),

                const SizedBox(width: 20,),
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Icon(
              Icons.chevron_right,
            )
          ],
        ),
      ),
    );
  }
}