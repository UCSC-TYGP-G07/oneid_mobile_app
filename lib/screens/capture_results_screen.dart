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
  State<CaptureResultsScreen> createState() => _CaptureResults();
}

class _CaptureResults extends State<CaptureResultsScreen> {
  bool isComplete = false;
  String photoFilePath = "";
  bool isUploading = false;
  bool isUploaded = false;
  bool isFailed = false;
  bool isBlurred = false;
  bool isVariedBackground = false;
  String responseMessage = "";
  bool isFinalizing = true;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 75,
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'NIC request submitted successfully',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ),
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

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://18.142.53.118:8100/icao_validate'));

    //File imageFile = File(widget.photoPath);
    // var imageUploadRequest = http.MultipartFile.fromPath('image', imageFile.path);
    // request.files.add(await imageUploadRequest);

    var imageFile2 = File(
        widget.photoPath); // Replace with the actual path to your image file
    var imageUploadRequest2 = http.MultipartFile.fromBytes(
        'file', await imageFile2.readAsBytes(),
        filename: 'image.jpg');
    request.files.add(imageUploadRequest2);

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
      // var message = jsonResponse['is_icao_compliant'];
      //
      // setState(() {
      //   responseMessage = "All checks passed";
      // });

      print(jsonResponse);

      if (jsonResponse['is_icao_compliant'] == true) {
        setState(() {
          isComplete = true;
          isFailed = false;
          responseMessage = "All checks passed";
        });
      } else {
        setState(() {
          isComplete = true;
          isFailed = true;
          responseMessage = "Validation failed, please try again";
        });
      }

      if (jsonResponse['blur']['is_blur'] == true) {
        setState(() {
          isBlurred = true;
        });
      } else {
        setState(() {
          isBlurred = false;
        });
      }

      if (jsonResponse['varied_bg']['is_varied_bg'] == true) {
        setState(() {
          isVariedBackground = true;
        });
      } else {
        setState(() {
          isVariedBackground = false;
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
                height: isComplete && isFailed ? 350 : 400,
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
            height: 12,
          ),
          !isUploaded
              ? Column(
                  children: [
                    const SpinKitFadingCircle(
                      color: OneIDColor.primaryColor,
                      size: 60.0,
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
              : Column(
                  children: [
                    Icon(
                      isFailed ? Icons.cancel : Icons.check_circle,
                      color: isFailed ? Colors.red : Colors.green,
                      size: 60.0,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      responseMessage,
                      style: TextStyle(
                        color: isFailed ? Colors.red : Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    isComplete && isFailed
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              isVariedBackground
                                  ? const Text(
                                      'Use a plain coloured background',
                                      style: TextStyle(
                                        color: OneIDColor.darkGrey,
                                        fontSize: 16,
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 4,
                              ),
                              isBlurred
                                  ? const Text(
                                      'Make sure the image is not blurred',
                                      style: TextStyle(
                                        color: OneIDColor.darkGrey,
                                        fontSize: 16,
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
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
                      onTap: isComplete && !isFailed
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
