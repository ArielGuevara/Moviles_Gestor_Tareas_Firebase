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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDU4H5GbsJm2vU5PFPTkKFa41rOiWjsK7c',
    appId: '1:235171097893:web:22610accbd4faded353ecc',
    messagingSenderId: '235171097893',
    projectId: 'fir-flutter-f7bc7',
    authDomain: 'fir-flutter-f7bc7.firebaseapp.com',
    storageBucket: 'fir-flutter-f7bc7.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4c9EiTmBL3DMuwxdhzr-FIIcNW0norz0',
    appId: '1:235171097893:android:0389a4ff5bf0462e353ecc',
    messagingSenderId: '235171097893',
    projectId: 'fir-flutter-f7bc7',
    storageBucket: 'fir-flutter-f7bc7.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDU4H5GbsJm2vU5PFPTkKFa41rOiWjsK7c',
    appId: '1:235171097893:web:b83be0fbbb5d85a1353ecc',
    messagingSenderId: '235171097893',
    projectId: 'fir-flutter-f7bc7',
    authDomain: 'fir-flutter-f7bc7.firebaseapp.com',
    storageBucket: 'fir-flutter-f7bc7.firebasestorage.app',
  );
}
