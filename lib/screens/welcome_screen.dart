import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../components/primary_button.dart';
import '../components/secondary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  //Sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            //Lock screen image

            Expanded(
                child: Center(
              child: Image(
                image: AssetImage("assets/images/oneid-logo.png"),
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            )),

            Expanded(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: Column(
                      children: [
                        const Text(
                          'Welcome to OneID!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        const SizedBox(height: 48),

                        //Login Button
                        SizedBox(
                          child: PrimaryButton(
                            buttonText: 'Login',
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),

                        //Verify ID Button
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          child: PrimaryButton(
                            buttonText: 'Verify ID',
                            onTap: () {},
                            color: OneIDColor.secondaryColor,
                          ),
                        ),

                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          'NEW USER?',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          child: SecondaryButton(
                            buttonText: 'Register',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  )),
            )
          ] //Children
              ),
        )));
  }
}
