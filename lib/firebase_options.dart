// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA2vo84bcmY-Rl6uE9Z8znwtqA-yifBy44',
    appId: '1:1051227046316:web:5f3697ecc14e01d92ffa09',
    messagingSenderId: '1051227046316',
    projectId: 'angiday-d741b',
    authDomain: 'angiday-d741b.firebaseapp.com',
    storageBucket: 'angiday-d741b.appspot.com',
    measurementId: 'G-LR2H4FKH6C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDebNR6J9sPwSMlym2yPLjuQeNNbcLl0y4',
    appId: '1:1051227046316:android:2d8420d28cc346d42ffa09',
    messagingSenderId: '1051227046316',
    projectId: 'angiday-d741b',
    storageBucket: 'angiday-d741b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdANHaeP66XRtjDdzV9WuZbg3XszDEhsI',
    appId: '1:1051227046316:ios:3250e81eca4163ce2ffa09',
    messagingSenderId: '1051227046316',
    projectId: 'angiday-d741b',
    storageBucket: 'angiday-d741b.appspot.com',
    iosBundleId: 'com.example.appMobiPharmacy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDdANHaeP66XRtjDdzV9WuZbg3XszDEhsI',
    appId: '1:1051227046316:ios:dda752e02fc47acc2ffa09',
    messagingSenderId: '1051227046316',
    projectId: 'angiday-d741b',
    storageBucket: 'angiday-d741b.appspot.com',
    iosBundleId: 'com.example.appMobiPharmacy.RunnerTests',
  );
}
