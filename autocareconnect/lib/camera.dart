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
    LocationData? _locationData;
    List<String> _images = [];


    @override
    void initState() {
      super.initState();
      _initializeCamera();
    }


    Future<void> _initializeCamera() async {
      final cameras = await availableCameras();
      _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
      await _cameraController!.initialize();
    }

    Future<void> _takePhoto() async {
      if (!_cameraController!.value.isInitialized) {
        return;
      }


      try {
        final XFile image = await _cameraController!.takePicture();
        setState(() {
          _images.add(image.path);
        });
      } catch (e) {
        print('Error taking a photo: $e');
      }
    }
   @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Take Picture of your car part'),
        ),
    
            Expanded(
              child: ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Image.file(File(_images[index]));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _takePhoto,
          child: Icon(Icons.camera),
        ),
      );
    }
  }
