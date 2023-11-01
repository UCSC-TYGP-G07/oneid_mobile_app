import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/models/register_req.dart';

import '../screens/login_screen.dart';
import '../services/api_service.dart';
import '../theme/colors.dart';
import '../util/constants.dart';

class RegisterController extends GetxController {
  final List<DropdownMenuItem<String>> genderOptionsList = [
    const DropdownMenuItem<String>(
      value: "male",
      child: Text("Male"),
    ),
    const DropdownMenuItem<String>(
      value: "female",
      child: Text("Female"),
    ),
  ];

  final List<DropdownMenuItem<String>> civilStatusOptionsList = [
    const DropdownMenuItem<String>(
      value: "single",
      child: Text("Single"),
    ),
    const DropdownMenuItem<String>(
      value: "married",
      child: Text("Married"),
    ),
    const DropdownMenuItem<String>(
      value: "widowed",
      child: Text("Widowed"),
    ),
    const DropdownMenuItem<String>(
      value: "separated",
      child: Text("Separated"),
    ),
    const DropdownMenuItem<String>(
      value: "divorced",
      child: Text("Divorced"),
    ),
  ];

  RxInt currentStep = 1.obs;
  RxInt totalSteps = 3.obs;

  final ApiService _apiService = ApiService();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  RxString selectedGender = ''.obs;
  final TextEditingController dobController = TextEditingController();

  final TextEditingController pobController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  RxString selectedCivilStatus = ''.obs;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool isRegisterLoading = false.obs;

  Future<bool> register() async {
    // check if all fields are filled
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        selectedGender.value.isEmpty ||
        dobController.text.isEmpty ||
        pobController.text.isEmpty ||
        occupationController.text.isEmpty ||
        selectedCivilStatus.value.isEmpty ||
        emailController.text.isEmpty ||
        mobileNoController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    // check if email is valid
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        backgroundColor: Colors.orange.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    // check if mobile number is valid
    if (!GetUtils.isPhoneNumber(mobileNoController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid mobile number',
        backgroundColor: Colors.orange.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    // check if password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Password and confirm password do not match',
        backgroundColor: Colors.red.withOpacity(0.9),
        colorText: OneIDColor.white,
      );
      return false;
    }

    isRegisterLoading.value = true;

    RegistrationRequest registerRequest = RegistrationRequest(
      firstName: lastNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      civilStatus: selectedCivilStatus.value,
      password: passwordController.text,
      birthPlace: pobController.text,
      occupation: occupationController.text,
      gender: selectedGender.value,
      dob: dobController.text,
      postalCode: postalCodeController.text,
      permanentAddress: addressController.text,
      phoneNumber: mobileNoController.text,
    );

    try {
      final response = await _apiService.sendPostRequest(
          false, // Authentication is not required for register
          registerEndpoint,
          data: registerRequest.toJson(),
          query: {
            'role': 'app-user',
          });

      isRegisterLoading.value = false;

      if (response == null) {
        return false;
      }

      if (response.statusCode == 403) {
        Get.snackbar(
          'Error',
          'Invalid email or password',
          colorText: Colors.red,
        );
      }

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Registration successful, please login',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: OneIDColor.white,
          icon: const Icon(
            Icons.check_circle,
            size: 26,
            color: Colors.white,
          ),
          shouldIconPulse: true,
        );

        Get.to(() => const LoginScreen());
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void onClose() {
    // Dispose of the controllers when the controller is closed
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    dobController.dispose();
    selectedGender.value = '';
    selectedCivilStatus.value = '';
    currentStep.value = 1;
    super.onClose();
  }
}
