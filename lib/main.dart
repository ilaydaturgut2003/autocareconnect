import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase package
import 'firebase_options.dart'; // Import Firebase options for initialization

import 'package:auto_route/auto_route.dart'; // AutoRoute package
import 'router.dart';
import 'router.gr.dart';

//import 'pages/home_page.dart'; // HomePage
//import 'pages/login_page.dart'; // LoginPage
//import 'pages/signup_page.dart'; // SignUpPage

//import 'package:autocareconnect/services/camera.dart'; // Camera package
//import 'package:autocareconnect/services/location.dart'; // Location package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

//MyApp
class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      
      title: 'AutoCare Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

/*
class CameraLocationPage extends StatefulWidget {
  @override
  _CameraLocationPageState createState() => _CameraLocationPageState();
}

class _CameraLocationPageState extends State<CameraLocationPage> {
  CameraController? _cameraController;
  LocationData? _locationData;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeLocation();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
  }

  Future<void> _initializeLocation() async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        _locationData = newLocation;
      });
    });
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
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location for Service'),
      ),
      body: Column(
        children: [
          _locationData != null
              ? Text('Location: ${_locationData!.latitude}, ${_locationData!.longitude}')
              : Text('Location data not available'),
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
} */