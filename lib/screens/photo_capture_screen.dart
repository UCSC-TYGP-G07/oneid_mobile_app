import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../util/camera_view.dart';
import '../util/face_detector_painter.dart';
import 'capture_results_screen.dart';

class PhotoCaptureScreen extends StatefulWidget {
  final Function(String path) setPhotoPath;

  const PhotoCaptureScreen({super.key, required this.setPhotoPath});

  @override
  State<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: false,
      enableContours: false,
      enableClassification: true,
      minFaceSize: 0.8,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  bool _canProcess = true;
  bool _isBusy = false;
  bool _faceDetected = false;
  CustomPaint? _customPaint;
  String _text = '';
  String _guide = '';

  var _cameraLensDirection = CameraLensDirection.back;
  bool isValid = false;
  bool isFaceValid = false;
  bool isEyesValid = false;
  bool isExpressionValid = false;

  List<Map<String, dynamic>> _validations = [
    {
      'description': 'Distance to face',
      'passed': false,
    },
    {
      'description': 'Head position',
      'passed': false,
    },
    {
      'description': 'Head angle',
      'passed': false,
    },
    {
      'description': 'Left eye',
      'passed': false,
    },
    {
      'description': 'Right eye',
      'passed': false,
    },
    {
      'description': 'Mouth expression',
      'passed': false,
    },
  ];

  late ProgressDialog progressDialog = ProgressDialog(context: context);

  void handleCaptureDone(String path) {
    print("Capture done");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CaptureResultsScreen(
          photoPath: path,
        ),
      ),
    );
    // Navigator.pop(context);
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
        title: 'Capture NIC Photo',
        customPaint: _customPaint,
        captureEnabled: isValid,
        text: _guide,
        faceDetected: _faceDetected,
        validations: _validations,
        onImage: _processImage,
        initialCameraLensDirection: _cameraLensDirection,
        onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        progressDialog: progressDialog,
        setPhotoPath: widget.setPhotoPath,
        handleCaptureDone: handleCaptureDone);
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });

    final faces = await _faceDetector.processImage(inputImage);
    await Future.delayed(const Duration(milliseconds: 200));
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(faces, inputImage.metadata!.size,
          inputImage.metadata!.rotation, _cameraLensDirection);
      _customPaint = CustomPaint(painter: painter);

      if (faces.isEmpty) {
        isValid = false;
        _text = 'No faces detected';
        _guide = 'Face not detected';

        if (_faceDetected) {
          HapticFeedback.lightImpact();
        }
        _faceDetected = false;
      }

      if (faces.length == 1) {
        _text = 'Face detected';
        _guide = '';

        if (!_faceDetected) {
          HapticFeedback.lightImpact();
        }
        _faceDetected = true;
        String text = '';

        var face = faces[0];

        double faceL = face.boundingBox.left;
        double faceT = face.boundingBox.top;
        double faceR = face.boundingBox.right;
        double faceB = face.boundingBox.bottom;

        double faceWidth = (faceL - faceR).abs();
        double faceHeight = (faceT - faceB).abs();
        double faceArea = faceWidth * faceHeight;

        String distanceMsg = '';

        // Face ===================================
        if (faceArea < 100000.0) {
          distanceMsg = 'Too far, move closer\n';
          if (_validations[0]['passed']) {
            HapticFeedback.lightImpact();
          }
          isFaceValid = false;
          _validations[0]['passed'] = false;
        }

        if (faceArea > 200000.0) {
          distanceMsg = 'Too close, move away\n';
          if (_validations[0]['passed']) {
            HapticFeedback.lightImpact();
          }
          isFaceValid = false;
          _validations[0]['passed'] = false;
        }

        if (faceArea >= 100000.0 && faceArea <= 200000.0) {
          distanceMsg = '✅ Face distance is correct\n';
          if (!_validations[0]['passed']) {
            HapticFeedback.lightImpact();
          }
          isFaceValid = true;
          _validations[0]['passed'] = true;
        }
        // =======================================

        // Eyes ===================================
        if (face.leftEyeOpenProbability! >= 0.25) {
          if (!_validations[3]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[3]['passed'] = true;
        } else {
          if (_validations[3]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[3]['passed'] = false;
        }

        if (face.rightEyeOpenProbability! >= 0.25) {
          if (!_validations[4]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[4]['passed'] = true;
        } else {
          if (_validations[4]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[4]['passed'] = false;
        }
        // =======================================

        // Smile ===================================
        if (face.smilingProbability! >= 0.35) {
          if (_validations[5]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[5]['passed'] = false;
        } else {
          if (!_validations[5]['passed']) {
            HapticFeedback.lightImpact();
          }
          _validations[5]['passed'] = true;
        }
        // =======================================

        // Final computations
        text += distanceMsg;
        distanceMsg = '';

        if (isFaceValid) {
          if ((faceL >= 125 && faceL <= 225) &&
              (faceT >= 350 && faceT <= 450) &&
              (faceR >= 540 && faceR <= 640) &&
              (faceB >= 750 && faceB <= 850)) {
            text += '✅ Face positioned correctly\n';
            _guide = 'OK 1';
            isFaceValid = true;
            if (!_validations[1]['passed']) {
              HapticFeedback.lightImpact();
            }
            _validations[1]['passed'] = true;
          } else {
            text += 'Bring your face inside the frame\n';
            _guide = 'Fit face inside the frame';
            isFaceValid = false;
            if (_validations[1]['passed']) {
              HapticFeedback.lightImpact();
            }
            _validations[1]['passed'] = false;
          }
        }

        if (isFaceValid) {
          if (face.headEulerAngleX! >= -10 &&
              face.headEulerAngleX! <= 20 &&
              face.headEulerAngleY! >= -10 &&
              face.headEulerAngleY! <= 10 &&
              face.headEulerAngleZ! >= -10 &&
              face.headEulerAngleZ! <= 10) {
            isFaceValid = true;
            text += '✅ Head straight\n';

            if (!_validations[2]['passed']) {
              HapticFeedback.lightImpact();
            }
            _validations[2]['passed'] = true;
          } else {
            isFaceValid = false;
            text += 'Keep your head straight\n';
            _guide = 'Keep head straight';

            if (_validations[2]['passed']) {
              HapticFeedback.lightImpact();
            }
            _validations[2]['passed'] = false;
          }
        }

        if (isFaceValid) {
          if (face.leftEyeOpenProbability! >= 0.25 &&
              face.rightEyeOpenProbability! >= 0.25) {
            text += '✅ Eyes open\n';

            isEyesValid = true;
          } else {
            text += 'Open your eyes\n';
            _guide = 'Keep both eyes open';
            isEyesValid = false;
          }

          if (face.smilingProbability! >= 0.35) {
            text += 'Show a neutral expression\n';
            _guide = 'Show a neutral expression, do not smile';
            isExpressionValid = false;
            _validations[4]['passed'] = false;
          } else {
            text += '✅ Expression OK';

            isExpressionValid = true;
            _validations[4]['passed'] = true;
          }

          if (isFaceValid && isEyesValid && isExpressionValid) {
            isValid = true;
            text += '\n\n😎 You can capture photo now!';

            _guide = 'Ready to capture';
            // HapticFeedback.lightImpact();
          } else {
            isValid = false;
          }
        }

        _text = text;
        // =======================================
      }

      if (faces.length > 1) {
        if (_faceDetected) {
          HapticFeedback.lightImpact();
        }
        _faceDetected = false;
        _text = 'More than one face detected';
        _guide = 'Multiple faces detected';
      }
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
