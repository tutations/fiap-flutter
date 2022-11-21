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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALJZdBAr9T5WN0NIofxvnIoVubAXHi-ec',
    appId: '1:20189165360:web:450e4b03925465eed37af5',
    messagingSenderId: '20189165360',
    projectId: 'flutter-artur',
    authDomain: 'flutter-artur.firebaseapp.com',
    storageBucket: 'flutter-artur.appspot.com',
    measurementId: 'G-KTEXVTT3W5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgJqLa9GtW1KzaZzVYiDmQwxSfcxXYGjU',
    appId: '1:20189165360:android:6ab778ca3b3f3d17d37af5',
    messagingSenderId: '20189165360',
    projectId: 'flutter-artur',
    storageBucket: 'flutter-artur.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD79zJY4KS8iD-KDO0SIPrAE5vJjlISgE0',
    appId: '1:20189165360:ios:17689cd07d7a7b25d37af5',
    messagingSenderId: '20189165360',
    projectId: 'flutter-artur',
    storageBucket: 'flutter-artur.appspot.com',
    iosClientId: '20189165360-gaerq54t1juuniu4rl6tefh9ph7bbupa.apps.googleusercontent.com',
    iosBundleId: 'com.arturclemente.trabalhofinal',
  );
}