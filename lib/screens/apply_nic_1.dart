import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';
import 'package:oneid_mobile_app/models/login_res.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../components/read_only_text_field.dart';
import '../controller/user_controller.dart';
import 'apply_nic_2.dart';

class ApplyNICScreen1 extends StatefulWidget {
  const ApplyNICScreen1({Key? key}) : super(key: key);

  @override
  State<ApplyNICScreen1> createState() => _ApplyNIC1();
}

class _ApplyNIC1 extends State<ApplyNICScreen1> {
  final searchController = TextEditingController();
  final UserController userController = Get.find<UserController>();

  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    User currentUser = userController.user.value!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Apply for NIC',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Set the height of your widget
          child: ProgressBar(
            step: 0,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Check your personal details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Visit Profile Settings to modify your personal details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: OneIDColor.darkGrey, fontSize: 14, height: 1.5),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  //User details form
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Full Name',
                            value:
                                '${currentUser.firstName} ${currentUser.lastName}',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Permanent Address',
                            value: '${currentUser.permanentAddress}',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              const ReadOnlyTextField(
                            labelText: 'District',
                            value: 'Colombo',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Date of Birth',
                            value: '${currentUser.permanentAddress}',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Place of Birth',
                            value: '${currentUser.birthPlace}',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Gender',
                            value: '${currentUser.gender}',
                          ),
                              const SizedBox(
                            height: 36,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Profession / Occupation / Job',
                            value: '${currentUser.occupation}',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Phone number',
                            value: '${currentUser.phoneNumber}',
                          ),
                              const SizedBox(
                            height: 24,
                          ),
                              ReadOnlyTextField(
                                labelText: 'Email address',
                            value: '${currentUser.email}',
                          ),
                              const SizedBox(
                            height: 12,
                          ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 85,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    buttonText: 'Next',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ApplyNICScreen2(
                                    birthCertFilePath: null,
                                  )));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }
}
