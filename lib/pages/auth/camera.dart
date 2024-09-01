import 'dart:io';
import 'dart:typed_data';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:snapfeast/misc/constants.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {



  void flipImage(File? file) async {

    if(file == null) {
      pop(null);
      return;
    }

    Uint8List imageBytes = await file.readAsBytes();
    img.Image original = img.decodeImage(imageBytes)!;
    img.Image flipped = img.flipHorizontal(original);
    Uint8List flippedBytes = img.encodeJpg(flipped);

    File imageFile = await File(file.path).writeAsBytes(flippedBytes);
    pop(imageFile);
  }

  void pop(File? file) => context.router.pop(file);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraCamera(
        cameraSide: CameraSide.back,
        mode: CameraMode.ratio16s9,
        onFile: flipImage,
        onCameraFlipped: (face) {

        },
      ),
    );
  }
}
