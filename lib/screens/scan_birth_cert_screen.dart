import 'dart:io';
import 'dart:typed_data';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:oneid_mobile_app/components/primary_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../components/secondary_button.dart';
import '../theme/colors.dart';
import 'apply_nic_2.dart';

class ScanBirthCertScreen extends StatefulWidget {
  const ScanBirthCertScreen({Key? key}) : super(key: key);

  @override
  State<ScanBirthCertScreen> createState() => _ScanBirthCert();
}

class _ScanBirthCert extends State<ScanBirthCertScreen> {
  List<String> _pictures = [];
  bool isComplete = false;
  late ProgressDialog progressDialog = ProgressDialog(context: context);

  final searchController = TextEditingController();

  void onFinishClick() {
    progressDialog.show(
      barrierColor: Colors.black.withOpacity(0.5),
      hideValue: true,
      progressValueColor: OneIDColor.secondaryColor,
      borderRadius: 16,
      elevation: 3,
      max: 100,
      msg: 'Loading...',
      progressBgColor: Colors.transparent,
    );

    Future.delayed(const Duration(seconds: 2), () {
      progressDialog.update(msg: 'Compressing images...');

      resizeImages(_pictures).then((value) {
        _pictures = value;

        progressDialog.update(msg: 'Saving as PDF...');

        getImageDetails(_pictures[0]);
        imagesToPdf(_pictures).then((value) {
          File file = File(value);
          print('${file.lengthSync()} bytes in PDF');

          Future.delayed(const Duration(seconds: 1), () {
            progressDialog.close();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ApplyNICScreen2(birthCertFilePath: value),
              ),
            );
          });
        });
      });
    });
  }

  void onPressed() async {
    List<String> pictures = [];
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];

      if (!mounted) return;
      setState(() {
        _pictures = pictures;

        if (_pictures.isNotEmpty) {
          isComplete = true;
        }
      });
    } catch (exception) {
      // Handle exception here
    }
  }

  Future<String> imagesToPdf(List<String> imagePaths) async {
    final pdf = pw.Document();
    for (var imagePath in imagePaths) {
      final image = img.decodeImage(File(imagePath).readAsBytesSync())!;
      final pdfImage = pw.MemoryImage(
        img.encodePng(image),
      );

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(
              child: pw.Image(pdfImage),
            );
          },
        ),
      );
    }

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String outputPath =
        '${appDocumentsDirectory.path}/birth certificate ${DateTime.now()}.pdf';

    final file = File(outputPath);
    File file2 = await file.writeAsBytes(await pdf.save(), flush: true);

    return file2.path;
  }

  void getImageDetails(String imagePath) {
    final file = File(imagePath);

    if (file.existsSync()) {
      final List<int> bytes = file.readAsBytesSync();
      final image = img.decodeImage(Uint8List.fromList(bytes));

      if (image != null) {
        print('Image Details:');
        print('Width: ${image.width}');
        print('Height: ${image.height}');
        print('Format: ${image.format}');
        print('Byte Size: ${bytes.length} bytes');
      } else {
        print('Failed to decode the image.');
      }
    } else {
      print('Image not found.');
    }
  }

  Future<List<String>> resizeImages(List<String> imagePaths) async {
    List<String> resizedImages = [];
    for (var imagePath in imagePaths) {
      final file = File(imagePath);

      if (file.existsSync()) {
        final List<int> bytes = file.readAsBytesSync();
        final image = img.decodeImage(Uint8List.fromList(bytes));

        if (image != null) {
          final resizedImage = img.copyResize(image, height: 1280);
          final compressedImage = img.encodeJpg(resizedImage, quality: 90);

          Directory appDocumentsDirectory =
              await getApplicationDocumentsDirectory();
          String outputPath =
              '${appDocumentsDirectory.path}/birth-cert ${DateTime.now()}.jpg';

          File(outputPath).writeAsBytesSync(compressedImage);
          print('Image resized with aspect ratio and compressed successfully.');
          resizedImages.add(outputPath);
        } else {
          print('Failed to decode the image.');
        }
      } else {
        print('Image not found.');
      }
    }
    return resizedImages;
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
          'Scan Birth Certificate',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: isComplete
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _pictures.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == 0
                          ? const EdgeInsets.fromLTRB(0, 32, 0, 16)
                          : const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          // Add a border radius
                          border: Border.all(
                              color: OneIDColor.grey), // Add a border color
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          // Clip content to border radius
                          child: Image.file(File(_pictures[index])),
                        ),
                      ),
                    );
                  },
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Image.asset('assets/images/add-doc-graphic.png',
                            width: double.infinity),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Tap the button below to open the camera, then scan both sides of your birth certificate and submit.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: OneIDColor.darkGrey,
                            fontSize: 16,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
        ),
      ),
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
                    buttonText: 'Open Camera',
                    onTap: onPressed,
                    color: OneIDColor.darkGrey,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    buttonText: 'Finish and Submit',
                    onTap: isComplete ? onFinishClick : null,
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
