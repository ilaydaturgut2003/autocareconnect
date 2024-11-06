import 'package:camera/camera.dart';

class CameraManager {
  CameraController? controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller!.initialize();
  }

  Future<XFile?> takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return null;
    }
    try {
      return await controller!.takePicture();
    } catch (e) {
      print("Error taking picture: $e");
      return null;
    }
  }

  void dispose() {
    controller?.dispose();
  }
}


/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:autocareconnect/services/camera.dart';
import 'package:autocareconnect/services/location.dart';


class _MyHomePageState extends State<MyHomePage> {
  CameraController? _cameraController;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }
}

class CameraController {
  CameraDescription? camera;
  CameraController? controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    // Assuming there is at least one camera available
    camera = cameras.first;

    controller = CameraController(
      camera!,
      ResolutionPreset.high,
    );
  await controller!.initialize();
  }

  Future<void> takePicture(String path) async {
    if (!controller!.value.isInitialized) {
      throw 'Camera not initialized';
    }
    try {
      await controller!.takePicture(path);
    } catch (e) {
      print(e); // Handle errors
    }
  }

  void dispose() {
    controller?.dispose();
  }
} */