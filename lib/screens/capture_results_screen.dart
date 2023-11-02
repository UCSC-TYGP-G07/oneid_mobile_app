import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/screens/photo_capture_screen.dart';
import 'package:oneid_mobile_app/util/constants.dart';

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
  Map<String, String> testMessages = {
    "too_dark_or_light": "Photo should not be too dark or too light",
    "geometry": "Face should have correct dimensions",
    "blurring": "Photo should not be blurred",
    "varied_bg": "Background should be plain colored",
    "eyes_closed": "Both eyes should be open",
    "looking_away": "The subject should look straight at the camera",
    "shadows_across_face": "No shadows should be present across the face",
    "mouth_open": "Mouth should be closed and have a suitable expression",
    "redeye": "There should be no red-eye visible in the photo",
    "hair_across_eyes": "There should be no hair across eyes",
    "illumination_intensity": "The face should be evenly lit",
    "hat_or_cap": "The subject should not be wearing hats/caps",
  };

  bool isComplete = false;
  String photoFilePath = "";
  bool isUploading = false;
  bool isUploaded = false;
  bool isFailed = false;
  String responseMessage = "";
  Map<String, dynamic> testResults = {};

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
          content: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
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

    var request =
        http.MultipartRequest('POST', Uri.parse('${icaoValidationUrl}'));

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
      Get.snackbar(
        'Success',
        'Image uploaded and processed successfully',
        backgroundColor: Colors.green.withOpacity(0.9),
        colorText: OneIDColor.white,
      );

      // Convert the response stream to a string
      var responseString = await response.stream.bytesToString();

      // Parse the JSON response
      var jsonResponse = json.decode(responseString);

      testResults = jsonResponse['tests'];

      print(jsonResponse);

      if (jsonResponse['all_passed'] == true) {
        setState(() {
          isComplete = true;
          isFailed = false;
          responseMessage = "All checks passed";
        });
      } else {
        setState(() {
          isComplete = true;
          isFailed = true;
          responseMessage = "Some checks failed";
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
          'ICAO Compliance Check',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: isComplete && isFailed ? 350 : 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Image.file(File(widget.photoPath)),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 12,
              ),
              isUploaded
                  ? SingleChildScrollView(
                      child: Column(
                        children: testResults.entries.map((entry) {
                          final testName = entry.key
                              .split('_')
                              .map((word) =>
                                  word[0].toUpperCase() + word.substring(1))
                              .join(' ');
                          final testResult = entry.value['is_passed'];
                          final message = testMessages[entry.key] ?? "";
                          final timeTaken =
                              entry.value['time_elapsed'] as double;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Show a tooltip indicating if the test passed or failed
                                    final testResult = entry.value['is_passed'];
                                    final resultText =
                                        testResult ? 'Passed' : 'Failed';
                                    final tooltipMessage =
                                        '$testName Test: $resultText';

                                    HapticFeedback.mediumImpact();

                                    Get.snackbar(
                                      'Test Result',
                                      tooltipMessage,
                                      duration: const Duration(seconds: 2),
                                      backgroundColor: testResult
                                          ? Colors.green.withOpacity(0.9)
                                          : Colors.red.withOpacity(0.9),
                                      colorText: OneIDColor.white,
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          testResult
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: testResult
                                              ? Colors.green
                                              : Colors.red,
                                          size: 24.0,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          testName + " Test",
                                          style: TextStyle(
                                            color: testResult
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                      color: OneIDColor.darkGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '(Time taken: ${timeTaken.toStringAsFixed(2)} seconds)',
                                    style: TextStyle(
                                      color: OneIDColor.lightBlue,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Divider(
                                  color: OneIDColor.grey,
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 4,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const Column(
                      children: [
                        SizedBox(height: 24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: OneIDColor.primaryColor,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Image is processing...',
                              style: TextStyle(
                                color: OneIDColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              SizedBox(height: 12),
            ]),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
