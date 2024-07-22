import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebasePlatformOptions {
  static const FirebasePlatformOptions instance = FirebasePlatformOptions._();
  const FirebasePlatformOptions._();

  static FirebaseOptions get defaultOption {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError('Unsupported platform');
      default:
        throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu9e09zH1dsZ5mpA1sUB9jhksygN_iT-c',
    appId: '1:7480761739:android:a0b0af086f201a7a17e38e',
    messagingSenderId: '7480761739',
    projectId: 'tracker-46146',
    storageBucket: 'tracker-46146.appspot.com',
    androidClientId: '7480761739.apps.googleusercontent.com',
  );
}
