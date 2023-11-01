import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/components/dropdown_field.dart';
import 'package:oneid_mobile_app/controller/register_controller.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../components/date_picker.dart';
import '../components/step_indicator.dart';
import '../components/textField.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GestureDetector(
        onTap: () {
          // Hide the keyboard when the outside of the text fields is clicked
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _mainContent(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Obx(() => Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (controller.currentStep.value > 1)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                            onPressed: () {
                              controller.currentStep.value--;
                            },
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Previous',
                                style: TextStyle(
                                  color: OneIDColor.darkGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ))),
                      ),
                    ),
                  if (controller.currentStep.value <=
                      controller.totalSteps.value)
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                controller.isRegisterLoading.value
                                    ? null
                                    : controller.currentStep.value ==
                                            controller.totalSteps.value
                                        ? controller.register()
                                        : controller.currentStep.value++;
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: controller.isRegisterLoading.value
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  : controller.currentStep.value ==
                                          controller.totalSteps.value
                                      ? const Text('Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ))
                                      : const Text('Next',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )))),
                    ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 32.0),
                      const Text(
                        "Sign up",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: OneIDColor.primaryColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        "Create your OneID account",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      StepIndicator(
                          numberOfSteps: controller.totalSteps.value,
                          currentStep: controller.currentStep.value),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            "Step ${controller.currentStep.value} of ${controller.totalSteps.value}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                  _renderFormStep(context),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _renderFormStep(context) {
    final RegisterController controller = Get.find();
    switch (controller.currentStep.value) {
      case 1:
        return _formStep1(controller, context);
      case 2:
        return _formStep2(controller);
      case 3:
        return _formStep3(controller);
      default:
        return _formStep1(controller, context);
    }
  }

  Widget _formStep1(RegisterController controller, context) {
    return Column(
      children: [
        MyTextField(
          controller: controller.firstNameController,
          labelText: 'First Name',
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          controller: controller.lastNameController,
          labelText: 'Last Name',
        ),
        const SizedBox(height: 24.0),
        MyDropdown(
            items: controller.genderOptionsList,
            selectedItem: controller.selectedGender.value == ''
                ? null
                : controller.selectedGender.value,
            labelText: "Gender",
            onItemSelected: (String? selectedItem) {
              controller.selectedGender.value = selectedItem!;
              if (kDebugMode) {
                print(selectedItem);
              }
            }),
        const SizedBox(height: 24.0),
        MyDatePicker(
          controller: controller.dobController,
          labelText: 'Date of Birth',
          selectedDate: DateTime(2000),
          onDateSelected: (DateTime selectedDateTime) {
            if (kDebugMode) {
              print(selectedDateTime);
            }
          },
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _formStep2(controller) {
    return Column(
      children: [
        MyTextField(
          controller: controller.pobController,
          labelText: 'Place of Birth',
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          controller: controller.occupationController,
          labelText: 'Occupation',
        ),
        const SizedBox(height: 24.0),
        MyDropdown(
            items: controller.civilStatusOptionsList,
            selectedItem: controller.selectedCivilStatus.value == ''
                ? null
                : controller.selectedCivilStatus.value,
            labelText: "Civil Status",
            onItemSelected: (String? selectedItem) {
              controller.selectedCivilStatus.value = selectedItem!;
              if (kDebugMode) {
                print(selectedItem);
              }
            }),
        const SizedBox(height: 24.0),
        MyTextField(
          controller: controller.addressController,
          labelText: 'Permanent Address',
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          keyboardType: TextInputType.number,
          controller: controller.postalCodeController,
          labelText: 'Postal Code',
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _formStep3(controller) {
    return Column(
      children: [
        MyTextField(
          controller: controller.emailController,
          labelText: 'Email address',
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          keyboardType: TextInputType.phone,
          controller: controller.mobileNoController,
          labelText: 'Mobile number',
        ),
        const SizedBox(height: 28.0),
        const Text(
          "Create a strong password with at least 8 characters, including numbers and symbols",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: OneIDColor.darkGrey,
          ),
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          obscureText: true,
          controller: controller.passwordController,
          labelText: 'Password',
        ),
        const SizedBox(height: 24.0),
        MyTextField(
          obscureText: true,
          controller: controller.confirmPasswordController,
          labelText: 'Confirm password',
        ),
        const SizedBox(height: 28),
        const Text(
          "By clicking on Register, you agree to OneID Terms of Service and Privacy Policy.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: OneIDColor.darkGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
