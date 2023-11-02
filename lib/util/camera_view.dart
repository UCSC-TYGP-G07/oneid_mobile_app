import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../theme/colors.dart';

class CameraView extends StatefulWidget {
  final Function(String path) setPhotoPath;
  final String title;
  final bool captureEnabled;
  final CustomPaint? customPaint;
  final String text;
  final bool faceDetected;
  final List<Map<String, dynamic>> validations;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialCameraLensDirection;
  final Function()? onCameraFeedReady;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final ProgressDialog progressDialog;
  final Function(String path) handleCaptureDone;

  const CameraView(
      {super.key,
      required this.title,
      required this.onImage,
      required this.captureEnabled,
      this.customPaint,
      required this.text,
      required this.faceDetected,
      required this.validations,
      this.initialCameraLensDirection = CameraLensDirection.back,
      this.onCameraFeedReady,
      this.onCameraLensDirectionChanged,
      required this.progressDialog,
      required this.setPhotoPath,
      required this.handleCaptureDone});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  bool _changingCameraLens = false;
  final double _cameraPreviewAspectRatio = 35 / 45;
  final searchController = TextEditingController();
  bool isCapturing = false;

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

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("List of cameras available: ${_cameras.toString()}");
    }

    _initialize();

    _startLiveFeed();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    if (kDebugMode) {
      print("Stopped live feed");
    }
    super.dispose();
  }

  void _openGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Navigate to the next page with the selected image
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CaptureResultsScreen(
      //       photoPath: pickedFile.path,
      //     ),
      //   ),
      // );

      Future.delayed(const Duration(seconds: 1), () {
        widget.progressDialog.close();
        widget.setPhotoPath(pickedFile.path);
        widget.handleCaptureDone(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Capture NIC Photo',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: IconButton(
                color: OneIDColor.darkGrey,
                onPressed: _switchCamera,
                icon: Icon(
                  Platform.isIOS
                      ? Icons.flip_camera_ios
                      : Icons.flip_camera_android,
                  size: 32,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: IconButton(
              color: OneIDColor.darkGrey,
              onPressed: _openGallery,
              // Add the onPressed handler for gallery button
              icon: const Icon(
                Icons.photo_library,
                size: 32,
              ),
            ),
          ),
        ],
      ),
      body: _liveFeedBody(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _liveFeedBody() {
    // if (_controller == null || !_controller!.value.isInitialized) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();

    final size = MediaQuery.of(this.context).size;
    var scale = size.aspectRatio * _controller!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              child: _changingCameraLens
                  ? const Center(
                      child: Text('Changing camera lens'),
                    )
                  : SizedBox(
                      width: MediaQuery.of(this.context).size.width,
                      height: MediaQuery.of(this.context).size.width /
                          _cameraPreviewAspectRatio,
                      child: ClipRect(
                        child: OverflowBox(
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SizedBox(
                              width: MediaQuery.of(this.context).size.width,
                              height: MediaQuery.of(this.context).size.width *
                                  _controller!.value.aspectRatio,
                              child: CameraPreview(
                                _controller!,
                                child: widget.customPaint,
                              ), // this is my CameraPreview
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/camera_overlay.png',
                width: MediaQuery.of(this.context).size.width,
              ),
            ),
            !isCapturing && widget.faceDetected
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 250,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 64),
                      child: SizedBox(
                        height: 128,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Set the border radius here
                          ),
                          color: Colors.white.withOpacity(0.8),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: widget.validations.length,
                            itemBuilder: (context, index) {
                              final validation = widget.validations[index];
                              final passed = validation['passed'];
                              final icon = passed ? Icons.check : Icons.close;

                              return Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${validation['description']}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(icon,
                                        size: 15,
                                        color:
                                            passed ? Colors.green : Colors.red),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 176,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        !isCapturing
                            ? widget.faceDetected
                                ? (widget.text)
                                : "No face detected"
                            : "Captured",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widget.text == 'Ready to capture'
                          ? const Padding(
                              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Icon(Icons.check,
                                  size: 24, color: Colors.green),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    if (kDebugMode) {
      print("Started live feed on camera: ${camera.name}");
    }
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });

      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    final camera = _cameras[_cameraIndex];
    InputImageRotation? rotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);

    // if (kDebugMode) {
    //   print(
    //       'Lens direction: ${camera.lensDirection}, Rotation: ${camera.sensorOrientation} [$rotation], ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    // }

    if (Platform.isAndroid) {
      switch (camera.lensDirection) {
        case CameraLensDirection.front:
          switch (_controller!.value.deviceOrientation) {
            case DeviceOrientation.portraitUp:
              rotation = InputImageRotation.rotation270deg;
              break;
            case DeviceOrientation.landscapeLeft:
              rotation = InputImageRotation.rotation0deg;
              break;
            case DeviceOrientation.portraitDown:
              rotation = InputImageRotation.rotation90deg;
              break;
            case DeviceOrientation.landscapeRight:
              rotation = InputImageRotation.rotation180deg;
              break;
          }
          break;

        case CameraLensDirection.back:
          switch (_controller!.value.deviceOrientation) {
            case DeviceOrientation.portraitUp:
              rotation = InputImageRotation.rotation90deg;
              break;
            case DeviceOrientation.landscapeLeft:
              rotation = InputImageRotation.rotation0deg;
              break;
            case DeviceOrientation.portraitDown:
              rotation = InputImageRotation.rotation270deg;
              break;
            case DeviceOrientation.landscapeRight:
              rotation = InputImageRotation.rotation180deg;
              break;
          }
          break;

        case CameraLensDirection.external:
          break;
      }
    }
    if (rotation == null) return null;
    // if (kDebugMode) {
    //   print('Final rotation: $rotation');
    // }

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  void _capturePhoto() async {
    if (!_controller!.value.isInitialized) {
      return;
    }
    _controller?.setFlashMode(FlashMode.off);
    HapticFeedback.mediumImpact();
    isCapturing = true;
    widget.progressDialog.show(
      barrierColor: Colors.black.withOpacity(0.5),
      hideValue: true,
      progressValueColor: OneIDColor.secondaryColor,
      borderRadius: 16,
      elevation: 3,
      max: 100,
      msg: 'Capturing...',
      progressBgColor: Colors.transparent,
    );

    try {
      final path = join(
        (await getApplicationDocumentsDirectory()).path,
        '${DateTime.now()}.png',
      );

      var capturedImage = await _controller?.takePicture();
      if (capturedImage == null) return;
      capturedImage.saveTo(path);

      Future.delayed(const Duration(seconds: 1), () {
        widget.progressDialog.update(msg: 'Saving image...');

        final bytes = File(capturedImage.path).readAsBytesSync();
        final img.Image? image = img.decodeImage(bytes);

        getImageDetails(path);

        if (image != null) {
          Future.delayed(const Duration(seconds: 1), () {
            widget.progressDialog.close();
            widget.setPhotoPath(path);
            widget.handleCaptureDone(path);
          });
        }

        // Process the captured photo path as needed (e.g., display it in an image widget)
      });
    } catch (e) {
      // Handle any errors that occur during photo capture
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Widget _floatingActionButton() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const SizedBox();
    }

    if (_cameras.length == 1) return const SizedBox();

    return SizedBox(
      height: 100,
      width: 80,
      child: FloatingActionButton(
        elevation: 3,
        onPressed: widget.captureEnabled ? () => _capturePhoto() : null,
        backgroundColor: widget.captureEnabled
            ? OneIDColor.tertiaryColor
            : Colors.grey.shade300,
        child: Icon(
          Icons.camera_alt,
          size: 40,
          color: widget.captureEnabled ? OneIDColor.primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
