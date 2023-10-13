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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHIBVNIYK9GRmCLDE_3_DSwBgUiMGHddc',
    appId: '1:842470327412:android:4ec7483a6ec5158a227d21',
    messagingSenderId: '842470327412',
    projectId: 'fir-dersleri-flutter-d855d',
    storageBucket: 'fir-dersleri-flutter-d855d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQ3QFaYXa-120Pnd6RGAaMEup7R_girOk',
    appId: '1:842470327412:ios:b06a376b9a0299fc227d21',
    messagingSenderId: '842470327412',
    projectId: 'fir-dersleri-flutter-d855d',
    storageBucket: 'fir-dersleri-flutter-d855d.appspot.com',
    iosClientId: '842470327412-mp1srda1qhcq106ph0n21cv1hb0diinu.apps.googleusercontent.com',
    iosBundleId: 'com.mekinbaturalp.udemyFirebaseCourse',
  );
}