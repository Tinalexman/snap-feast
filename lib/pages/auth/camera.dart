import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:snapfeast/misc/constants.dart';


class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraCamera(
          onFile: (file) => context.router.pop(file)
      ),
    );
  }
}

