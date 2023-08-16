import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  FaceDetectorPainter(
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.red;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..color = Colors.green;

    for (final Face face in faces) {
      final left = translateX(
        face.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        face.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        face.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        face.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint1,
      );

      // Draw contours
      // void paintContour(final FaceContourType type) {
      //   final FaceContour? faceContour = face.contours[type];
      //   if (faceContour?.points != null) {
      //     // final List<Offset> facePoints = faceContour!.points!.map((contour) {
      //     //   return Offset(
      //     //     translateX(contour.x as double, rotation, size, absoluteImageSize),
      //     //     translateY(contour.y as double, rotation, size, absoluteImageSize),
      //     //   );
      //     // }).toList();
      //     // final path = Path();
      //     // path.addPolygon(facePoints, true);
      //     // canvas.drawPath(path, paint);
      //
      //     for (final Point point in faceContour!.points!) {
      //       canvas.drawCircle(
      //           Offset(
      //             translateX(
      //                 point.x.toDouble(), rotation, size, absoluteImageSize),
      //             translateY(
      //                 point.y.toDouble(), rotation, size, absoluteImageSize),
      //           ),
      //           1.0,
      //           paint);
      //     }
      //
      //     paintContour(FaceContourType.face);
      //     paintContour(FaceContourType.leftEyebrowTop);
      //     paintContour(FaceContourType.leftEyebrowBottom);
      //     paintContour(FaceContourType.rightEyebrowTop);
      //     paintContour(FaceContourType.rightEyebrowBottom);
      //     paintContour(FaceContourType.leftEye);
      //     paintContour(FaceContourType.rightEye);
      //     paintContour(FaceContourType.upperLipTop);
      //     paintContour(FaceContourType.upperLipBottom);
      //     paintContour(FaceContourType.lowerLipTop);
      //     paintContour(FaceContourType.lowerLipBottom);
      //     paintContour(FaceContourType.noseBridge);
      //     paintContour(FaceContourType.noseBottom);
      //     paintContour(FaceContourType.leftCheek);
      //     paintContour(FaceContourType.rightCheek);
      //
      //   }
      // }

      void paintContour(FaceContourType type) {
        final contour = face.contours[type];
        if (contour?.points != null) {
          for (final Point point in contour!.points) {
            canvas.drawCircle(
                Offset(
                  translateX(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                  translateY(
                    point.y.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  ),
                ),
                1,
                paint1);
          }
        }
      }

      void paintLandmark(FaceLandmarkType type) {
        final landmark = face.landmarks[type];
        if (landmark?.position != null) {
          canvas.drawCircle(
              Offset(
                translateX(
                  landmark!.position.x.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
                translateY(
                  landmark.position.y.toDouble(),
                  size,
                  imageSize,
                  rotation,
                  cameraLensDirection,
                ),
              ),
              2,
              paint2);
        }
      }

      for (final type in FaceContourType.values) {
        paintContour(type);
      }

      for (final type in FaceLandmarkType.values) {
        paintLandmark(type);
      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}
