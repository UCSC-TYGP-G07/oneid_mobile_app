import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';

import '../../components/primary_button.dart';
import '../apply_dl.dart';

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
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              //Progress Bar
              const SizedBox(
                height: 30,
              ),
              ProgressBar(
                step: 0,
              ),

              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select the personal identification \n document you need to apply for',
                      style: TextStyle(
                        color: const Color(0xFF27187E),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  )),

              //Buttons
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'Driving License',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplyDL(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'NIC',
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  buttonText: 'Passport',
                  onTap: () {},
                ),
              ),

              const SizedBox(
                height: 40,
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
