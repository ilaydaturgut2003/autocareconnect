import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart';

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
          title: Text('AutoCare Connect: Use camera and location to locate your car'),
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
  }
  
