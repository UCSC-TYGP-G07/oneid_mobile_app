import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../../components/primary_button.dart';

class ApplyForIDsScreen extends StatefulWidget {
  const ApplyForIDsScreen({Key? key}) : super(key: key);

  @override
  State<ApplyForIDsScreen> createState() => _GetIDs();
}

class _GetIDs extends State<ApplyForIDsScreen> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            children: [
              //Progress Bar
              const SizedBox(
                height: 72,
              ),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Select the personal identification \n document you wish to apply for',
                  style: TextStyle(
                      color: OneIDColor.black, fontSize: 20, height: 1.5),
                ),
              ),

              //Buttons
              const SizedBox(
                height: 72,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'Driving License',
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 48,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'NIC',
                  onTap: () {
                    Navigator.pushNamed(context, '/apply-nic');
                  },
                ),
              ),

              const SizedBox(
                height: 48,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'Passport',
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 48,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'Third Party IDs',
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
