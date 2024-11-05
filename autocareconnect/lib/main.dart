import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart'; // AutoRoute
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import Firebase options for initialization
import 'router.dart'; // Import the generated router file
import 'router.gr.dart';
import 'pages/home_page.dart'; // HomePage
import 'pages/login_page.dart'; // LoginPage
import 'pages/signup_page.dart'; // SignUpPage
import 'package:camera/camera.dart'; // Camera Functionality
import 'package:location/location.dart'; // Location Functionality

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

//MyApp
class MyApp extends StatelessWidget {
  // Create the AppRouter instance
  final _appRouter = AppRouter();

class _MyHomePageState extends State<MyHomePage> {
    CameraController? _cameraController;
    LocationData? _locationData;
    List<String> _images = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      
      title: 'AutoCare Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
  }
  
    }
  }
};
