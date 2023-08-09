import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/textField.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign user in method
  void signUserIn() {
    Navigator.pushReplacementNamed(context, '/');
  }

  // Create a FocusNode to manage the focus of the text field.
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Hide keyboard when user taps outside of textfield
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.blue.shade900,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(children: [
                //Welcome Text
                const SizedBox(height: 16),
                const Text(
                  'Sign in to OneID',
                  style: TextStyle(
                    color: OneIDColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 40),

                //Email textfield
                MyTextField(
                  controller: emailController,
                  labelText: 'Email address',
                  obscureText: false,
                ),

                const SizedBox(height: 24),

                //Password textfield
                MyTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 40),

                //Login Button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          signUserIn();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )))),

                const SizedBox(height: 20),

                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
                        visualDensity: VisualDensity.standard,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: OneIDColor.darkGrey,
                        fontSize: 14,
                      ),
                    )),

                Expanded(
                    child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: OneIDColor.darkGrey,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 4)),
                              visualDensity: VisualDensity.compact,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          onPressed: () {},
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: OneIDColor.primaryColor,
                              fontSize: 14,
                            ),
                          ))
                    ],
                  ),
                ))
              ] //Children
                  ),
            ),
          ))),
    );
  }
}
