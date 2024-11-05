import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';

void main() {
    runApp(MyApp());
  }


  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: MyHomePage(),
      );
    }
  }


  class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();
  }


  class _MyHomePageState extends State<MyHomePage> {
    CameraController? _cameraController;
    List<String> _images = [];


    @override
    void initState() {
      super.initState();
      _initializeCamera();
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
}

    
