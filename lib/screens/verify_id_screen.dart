import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../theme/colors.dart';

class VerifyIDScreen extends StatefulWidget {
  const VerifyIDScreen({Key? key}) : super(key: key);

  @override
  State<VerifyIDScreen> createState() => _VerifyID();
}

class _VerifyID extends State<VerifyIDScreen> {
  bool isDone = false;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SizedBox(
              width: double.infinity,
              height: 340,
              child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          "NIC Card",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: 4),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image on the left
                            Container(
                                width: 150,
                                height: 200,
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  // Adjust the radius as needed
                                  child:
                                      Image.asset("assets/images/pro-pic.jpeg"),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            // ID card details on the right
                            const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Name: ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        'Masha Nilushi',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: OneIDColor.primaryColor),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ID Number: ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '12345',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: OneIDColor.primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.all(2));
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
          },
        ),
        title: const Text(
          'Verify ID',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
          torchEnabled: false,
        ),
        onDetect: (capture) {
          if (!isDone) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
              _showSuccessDialog(context);
              setState(() {
                isDone = true;
              });
              return;
            }
          }
        },
      ),
    );
  }
}
