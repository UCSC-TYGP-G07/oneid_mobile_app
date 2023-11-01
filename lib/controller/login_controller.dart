import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/controller/user_controller.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../models/login_req.dart';
import '../models/login_res.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../util/constants.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoginLoading = false.obs;

  Future<bool> login() async {
    // check if all fields are filled
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    // validate email
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    isLoginLoading.value = true;

    // Hide keyboard
    FocusScope.of(Get.context!).unfocus();

    LoginRequest loginRequest = LoginRequest(
        email: emailController.text, password: passwordController.text);
    try {
      final response = await _apiService.sendPostRequest(
        false, // authentication is not required for login
        loginEndpoint,
        data: loginRequest.toJson(),
      );

      if (response == null) {
        isLoginLoading.value = false;
        return false;
      }
      //
      // if (response.statusCode == 403 || response.statusCode == 404) {
      //   Get.snackbar(
      //     'Error',
      //     'Invalid email or password',
      //     backgroundColor: Colors.red.withOpacity(0.9),
      //     colorText: OneIDColor.white,
      //   );
      // }

      print(response.body);

      if (response.statusCode != 200) {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'];

        Get.snackbar(
          'Error',
          errorMessage.toString(),
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: OneIDColor.white,
        );
        isLoginLoading.value = false;
        return false;
      } else {
        Get.snackbar(
          'Success',
          'Login successful',
          backgroundColor: Colors.green.withOpacity(0.9),
          colorText: OneIDColor.white,
        );

        // Assuming the response contains authentication-related data
        LoginResponse loginResponse = LoginResponse.fromJson(response.body);

        final authService = Get.find<AuthService>();
        authService.setUserEmail(loginResponse.user.email);
        authService.setAuthentication(true);
        authService.updateBearerToken(loginResponse.accessToken);

        // save user data in getX state
        final userController = Get.find<UserController>();
        userController.setUser(loginResponse.user);

        // Redirect after 1 second
        Future.delayed(const Duration(seconds: 1), () {
          isLoginLoading.value = false;
          Get.offAllNamed('/main');
        });

        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
