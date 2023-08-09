import 'package:flutter/material.dart';

class IDWalletScreen extends StatefulWidget {
  const IDWalletScreen({Key? key}) : super(key: key);

  @override
  State<IDWalletScreen> createState() => _Wallet();
}

class _Wallet extends State<IDWalletScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            //Ongoing approvals
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'OneID Wallet',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ),

            ],
          ),
        )
      ),
    );
  }
}