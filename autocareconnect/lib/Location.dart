import 'dart:io';
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
    LocationData? _locationData;
    List<String> _images = [];


    @override
    void initState() {
      super.initState();
      _initializeLocation();
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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Photo & Location App'),
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
