import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';
import 'package:oneid_mobile_app/components/secondary_button.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class ApplyNICScreen2 extends StatefulWidget {
  final String? birthCertFilePath;

  const ApplyNICScreen2({Key? key, this.birthCertFilePath}) : super(key: key);


  @override
  State<ApplyNICScreen2> createState() => _ApplyNIC2();
}

class _ApplyNIC2 extends State<ApplyNICScreen2> {
  final searchController = TextEditingController();

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
            step: 1,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
            height: double.infinity,
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
                        'Upload support documents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Use your phone to capture the following documents',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: OneIDColor.darkGrey,
                            fontSize: 14,
                            height: 1.5),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SecondaryButton(
                          onTap: () {}, buttonText: 'View guidelines'),
                      const SizedBox(
                        height: 48,
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/scan-birth-cert');
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16,),
                                        widget.birthCertFilePath != ""
                                            ? Icon(Icons.check_circle,
                                          color: Colors.green, size: 64,)
                                            : Icon(Icons.document_scanner,
                                          color: OneIDColor.darkGrey,
                                          size: 64,),
                                        const SizedBox(height: 12,),
                                        const Text('Birth Certificate',
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),),
                                        const SizedBox(height: 2,),
                                        widget.birthCertFilePath != ""
                                            ? const Text('Document saved',
                                          style: TextStyle(color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),)
                                            : const Text('Not captured',
                                          style: TextStyle(color: Colors.red,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    buttonText: 'Next',
                    onTap: widget.birthCertFilePath != "" ? () {
                      Navigator.pushNamed(context, '/apply-nic-3');
                    } : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
