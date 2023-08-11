import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';
import 'package:oneid_mobile_app/components/secondary_button.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

import 'apply_nic_3.dart';

class ApplyNICScreen2 extends StatefulWidget {
  final String? birthCertFilePath;

  const ApplyNICScreen2({Key? key, this.birthCertFilePath}) : super(key: key);

  @override
  State<ApplyNICScreen2> createState() => _ApplyNIC2();
}

class _ApplyNIC2 extends State<ApplyNICScreen2> {
  void _showGuidelinesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'General Guidelines for Scanning Documents',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                  '1. Find a well-lit area to scan your document. Natural light or evenly distributed indoor lighting can help improve scan quality.'),
              SizedBox(height: 12),
              Text(
                  '2. Hold your phone parallel to the document and keep it steady.'),
              SizedBox(height: 12),
              Text(
                  '3. Place the document on a flat surface and make sure there are no shadows cast over it.'),
              SizedBox(height: 12),
              Text(
                  '4. Place the document against a plain and contrasting background.'),
              SizedBox(height: 12),
              Text(
                  '5. Position the document within the camera\'s frame, making sure all edges are visible.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

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
                        color: OneIDColor.darkGrey, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SecondaryButton(
                      onTap: () {
                        _showGuidelinesDialog(context);
                      },
                      buttonText: 'View guidelines'),
                  const SizedBox(
                    height: 48,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/scan-birth-cert');
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    widget.birthCertFilePath != null
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 64,
                                          )
                                        : const Icon(
                                            Icons.document_scanner,
                                            color: OneIDColor.darkGrey,
                                            size: 64,
                                          ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      'Birth Certificate',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    widget.birthCertFilePath != null
                                        ? const Text(
                                            'Document saved',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            'Not captured',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                  child: SecondaryButton(
                    buttonText: 'Previous',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    buttonText: 'Next',
                    onTap: widget.birthCertFilePath != null
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplyNICScreen3(
                                          birthCertFilePath:
                                              widget.birthCertFilePath,
                                        )));
                          }
                        : null,
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
