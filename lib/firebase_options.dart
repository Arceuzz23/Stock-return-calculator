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
    apiKey: 'AIzaSyCf7Fu56XEHUdOZ0QDoMzGjh4vEsfENiYc',
    appId: '1:572543485404:web:5c56440c2b470d7a0d3b19',
    messagingSenderId: '572543485404',
    projectId: 'stock-return-calci',
    authDomain: 'stock-return-calci.firebaseapp.com',
    storageBucket: 'stock-return-calci.appspot.com',
    measurementId: 'G-MP7CLRS0BE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpYAWqAc3ao7KPIsze8t-wgG9XMTdK2zM',
    appId: '1:572543485404:android:2d11787fbaade59e0d3b19',
    messagingSenderId: '572543485404',
    projectId: 'stock-return-calci',
    storageBucket: 'stock-return-calci.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVgLV61c1Sfo2V1jFx9j23dpEkv4FRKGw',
    appId: '1:572543485404:ios:4d388d1ef20860ef0d3b19',
    messagingSenderId: '572543485404',
    projectId: 'stock-return-calci',
    storageBucket: 'stock-return-calci.appspot.com',
    iosBundleId: 'com.example.stockReturnCalculator',
  );
}
