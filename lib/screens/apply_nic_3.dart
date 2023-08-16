import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:oneid_mobile_app/components/progress_bar.dart';
import 'package:oneid_mobile_app/components/secondary_button.dart';
import 'package:oneid_mobile_app/screens/capture_intro_screen.dart';
import 'package:oneid_mobile_app/theme/colors.dart';

class ApplyNICScreen3 extends StatefulWidget {
  final String? birthCertFilePath;

  const ApplyNICScreen3({Key? key, this.birthCertFilePath}) : super(key: key);

  @override
  State<ApplyNICScreen3> createState() => _ApplyNIC2();
}

class _ApplyNIC2 extends State<ApplyNICScreen3> {
  int _selectedCaptureMethod = 1; // Initial selected value
  String? photoFilePath;

  void setPhotoPath(photoPath) {
    setState(() {
      photoFilePath = photoPath;
    });
    print(photoFilePath);
  }

  void _showGuidelinesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'ICAO Guidelines for Photographs',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text('1. The image must have adequate brightness and contrast'),
              SizedBox(height: 8),
              Text(
                  '2. The skin tone should be natural. In case of over-exposure or under-exposure of the photo, the skin is either too dark or too light, photo will not be acceptable'),
              SizedBox(height: 8),
              Text(
                  '3. It should show a close up of the head and (partial) shoulders'),
              SizedBox(height: 8),
              Text(
                  '4. The image should be straight looking, centered with neutral expression'),
              SizedBox(height: 8),
              Text(
                  '5. Face should be in sharp focus and clear with no ink marks/creases/lines'),
              SizedBox(height: 8),
              Text(
                  '6. The face (from forehead edge to bottom of chin) should be 70 to 80% of the photo or one inch high'),
              SizedBox(height: 8),
              Text('7. The eyes must be open and no hair obscuring the face'),
              SizedBox(height: 8),
              Text(
                  '8. Prescription glasses if worn should be clear and thin framed and should not have flash reflection or obscure the eyes'),
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

  Widget captureNowSection() {
    return Column(children: [
      SecondaryButton(
          onTap: () {
            _showGuidelinesDialog(context);
          },
          buttonText: 'View guidelines'),
      const SizedBox(
        height: 40,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CaptureIntroScreen(setPhotoPath: setPhotoPath)),
                  );
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
                        photoFilePath != null
                            ? const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 64,
                              )
                            : const Icon(
                                Icons.portrait_rounded,
                                color: OneIDColor.darkGrey,
                                size: 64,
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Front Facing Photo',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        photoFilePath != null
                            ? const Text(
                                'Photo saved',
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
    ]);
  }

  Widget visitStudioSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 1,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Application ref no:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '#A65B4123',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
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
            step: 2,
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
                    'Capture Photograph',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Select how you would like to capture your photograph',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: OneIDColor.darkGrey, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _selectedCaptureMethod,
                            onChanged: (value) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                _selectedCaptureMethod = value!;
                              });
                            },
                          ),
                          const Text(
                            'Capture now',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            toggleable: false,
                            value: 2,
                            groupValue: _selectedCaptureMethod,
                            onChanged: (value) {
                              HapticFeedback.lightImpact();
                              setState(() {
                                _selectedCaptureMethod = value!;
                              });
                            },
                          ),
                          const Text(
                            'Visit studio',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  _selectedCaptureMethod == 1
                      ? captureNowSection()
                      : visitStudioSection(),
                ],
              ),
            ),
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 80,
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
                    onTap: photoFilePath != null || _selectedCaptureMethod == 2
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
