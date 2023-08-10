import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';
import 'package:oneid_mobile_app/components/secondary_button.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import '../components/ReadOnlyTextField.dart';
import 'apply_nic_2.dart';

class ApplyNICScreen1 extends StatefulWidget {
  const ApplyNICScreen1({Key? key}) : super(key: key);

  @override
  State<ApplyNICScreen1> createState() => _ApplyNIC1();
}

class _ApplyNIC1 extends State<ApplyNICScreen1> {
  final searchController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
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
        child: const SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Check your personal details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Visit Profile Settings to modify your personal details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: OneIDColor.darkGrey, fontSize: 14, height: 1.5),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  //User details form
                  Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Full Name',
                            value: 'Masha Nilushi Pupulewaththe',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Permanent Address',
                            value:
                                'No. 123, Mala Kolang Lanthaya, Athurugiriya, Western, Sri Lanka',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'District',
                            value: 'Colombo',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Date of Birth',
                            value: '01-04-1999',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Place of Birth',
                            value: 'Colombo',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Gender',
                            value: 'Female',
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Profession / Occupation / Job',
                            value: 'House-wife',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 120),
                            child: Divider(
                              color: OneIDColor.grey,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Phone number',
                            value: '+94 (76) 339 7994',
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ReadOnlyTextField(
                            labelText: 'Email address',
                            value: 'mashanilushi@gmail.com',
                          ),
                          SizedBox(
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
        height: 90,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SecondaryButton(
                    buttonText: 'Previous',
                    onTap: null,
                    color: OneIDColor.darkGrey,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    buttonText: 'Next',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyNICScreen2(
                                    birthCertFilePath: "",
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
