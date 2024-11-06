// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeL9iorjwcNYaK_9XRCN7W_ylZIlhOPo8',
    appId: '1:836543285782:android:4f91bab8004fa93a7d4337',
    messagingSenderId: '836543285782',
    projectId: 'autocare-connect-814ca',
    storageBucket: 'autocare-connect-814ca.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBg34x8oJMEBB8_U4BJsAguknltfXfIkto',
    appId: '1:836543285782:web:a4332039dfeea14c7d4337',
    messagingSenderId: '836543285782',
    projectId: 'autocare-connect-814ca',
    authDomain: 'autocare-connect-814ca.firebaseapp.com',
    storageBucket: 'autocare-connect-814ca.appspot.com',
    measurementId: 'G-G1LMMNK4P0',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCaf2aqF2Bnwk2c09DYU1fQu_ZHRHcmvug',
    appId: '1:836543285782:ios:43fc8a095f3c3b4a7d4337',
    messagingSenderId: '836543285782',
    projectId: 'autocare-connect-814ca',
    storageBucket: 'autocare-connect-814ca.appspot.com',
    iosBundleId: 'com.example.autocareconnect',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaf2aqF2Bnwk2c09DYU1fQu_ZHRHcmvug',
    appId: '1:836543285782:ios:43fc8a095f3c3b4a7d4337',
    messagingSenderId: '836543285782',
    projectId: 'autocare-connect-814ca',
    storageBucket: 'autocare-connect-814ca.appspot.com',
    iosBundleId: 'com.example.autocareconnect',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBg34x8oJMEBB8_U4BJsAguknltfXfIkto',
    appId: '1:836543285782:web:58ab8db7c98bc2fc7d4337',
    messagingSenderId: '836543285782',
    projectId: 'autocare-connect-814ca',
    authDomain: 'autocare-connect-814ca.firebaseapp.com',
    storageBucket: 'autocare-connect-814ca.appspot.com',
    measurementId: 'G-Q1JBVJM49T',
  );

}