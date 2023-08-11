import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/screens/photo_capture_screen.dart';

import '../components/secondary_button.dart';
import '../theme/colors.dart';

class CaptureResultsScreen extends StatefulWidget {
  final String photoPath;

  const CaptureResultsScreen({Key? key, required this.photoPath})
      : super(key: key);

  @override
  State<CaptureResultsScreen> createState() => _ApplyNIC2();
}

class _ApplyNIC2 extends State<CaptureResultsScreen> {
  bool isComplete = false;
  String photoFilePath = "";
  bool isUploading = false;
  bool isUploaded = false;
  String responseMessage = "";

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 60,
          ),
          content: Text('NIC request submitted successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/'),
                );
              },
              child: Text('Go to ID wallet'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendImageToServer() async {
    setState(() {
      isUploading = true;
    });
    File imageFile = File(widget.photoPath);

    var imageUploadRequest =
        http.MultipartFile.fromPath('image', imageFile.path);

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:3000/api/v1/ocr'));
    request.files.add(await imageUploadRequest);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isUploading = false;
      });
    });

    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        isUploading = false;
        isUploaded = true;
      });
      print('Image uploaded successfully');

      // Convert the response stream to a string
      var responseString = await response.stream.bytesToString();

      // Parse the JSON response
      var jsonResponse = json.decode(responseString);

      // Extract the "message" property
      var message = jsonResponse['message'];

      setState(() {
        responseMessage = message;
      });

      if (jsonResponse['status'] == 'pass') {
        setState(() {
          isComplete = true;
        });
      }
    } else {
      setState(() {
        isUploading = false;
      });
      print('Image upload failed with status code ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    sendImageToServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'NIC Photo Check',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  // Add a border radius
                  border:
                      Border.all(color: OneIDColor.grey), // Add a border color
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  // Clip content to border radius
                  child: Image.file(File(widget.photoPath)),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          !isUploaded
              ? Column(
                  children: [
                    const SpinKitFadingCircle(
                      color: OneIDColor.primaryColor,
                      size: 50.0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      isUploading ? 'Uploading...' : 'Processing...',
                      style: const TextStyle(
                        color: OneIDColor.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              : const Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'All tests passed',
                      style: TextStyle(
                        color: OneIDColor.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 80,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SecondaryButton(
                    buttonText: 'Re-capture',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoCaptureScreen(
                            setPhotoPath: (String path) {},
                          ),
                        ),
                      );
                    },
                    color: OneIDColor.darkGrey,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                      buttonText: 'Finish and Submit',
                      onTap: isComplete
                          ? () {
                              _showSuccessDialog(context);
                            }
                          : null),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
