import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/components/textField.dart';
import 'package:oneid_mobile_app/controller/login_controller.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

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
            color: OneIDColor.darkBlue,
            onPressed: () {
              Get.offAllNamed('/welcome');
            },
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 24),
              const Column(
                children: [
                  Text(
                    "Sign in to OneID",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: OneIDColor.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    "Sign in to access all your IDs",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              //Email text-field
              MyTextField(
                controller: controller.emailController,
                labelText: 'Email address',
                obscureText: false,
              ),

              const SizedBox(height: 24),

              //Password text-field
              MyTextField(
                controller: controller.passwordController,
                labelText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              //Login Button
              SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                        onPressed: controller.isLoginLoading.value
                            ? null
                            : controller.login,
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: controller.isLoginLoading.value
                            ? const SpinKitFadingCircle(
                                size: 20,
                                color: Colors.white,
                              )
                            : const Text('Sign in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ))),
                  )),

              const SizedBox(height: 20),

              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16)),
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
            ] //Children
                    ),
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: OneIDColor.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: OneIDColor.primaryColor,
                        fontSize: 14,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
