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
    apiKey: 'AIzaSyB1Ag1XmHQlXuP-2MW7vH5_R7gYhZR_Rb8',
    appId: '1:20913228861:web:76a5facd9c3b3f66bbee54',
    messagingSenderId: '20913228861',
    projectId: 'mychatapp-f6709',
    authDomain: 'mychatapp-f6709.firebaseapp.com',
    storageBucket: 'mychatapp-f6709.appspot.com',
    measurementId: 'G-VYLDD0KK9E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcga9S9glHvpwgq3cargjywBTy5D49E78',
    appId: '1:20913228861:android:3583b74ad321dec9bbee54',
    messagingSenderId: '20913228861',
    projectId: 'mychatapp-f6709',
    storageBucket: 'mychatapp-f6709.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAW8NtMfGz-gXxBKnvFsCnJUammGozZ5LA',
    appId: '1:20913228861:ios:48072d31a314720bbbee54',
    messagingSenderId: '20913228861',
    projectId: 'mychatapp-f6709',
    storageBucket: 'mychatapp-f6709.appspot.com',
    iosBundleId: 'com.example.mychatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAW8NtMfGz-gXxBKnvFsCnJUammGozZ5LA',
    appId: '1:20913228861:ios:f6fbe3a1c585a3f2bbee54',
    messagingSenderId: '20913228861',
    projectId: 'mychatapp-f6709',
    storageBucket: 'mychatapp-f6709.appspot.com',
    iosBundleId: 'com.example.mychatapp.RunnerTests',
  );
}
