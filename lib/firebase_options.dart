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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDr8b0Fz5b9ihd2KjWjGrohUdBvJf4zVoI',
    appId: '1:1064202474797:web:d7283ed241f4a2a6b4efa4',
    messagingSenderId: '1064202474797',
    projectId: 'pokemon-3172d',
    authDomain: 'pokemon-3172d.firebaseapp.com',
    storageBucket: 'pokemon-3172d.firebasestorage.app',
    measurementId: 'G-4ZK63EM20H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw7yiZ5vdmNTeqcJvNglWETH3KoV7ApWs',
    appId: '1:1064202474797:android:ded72a30c7c34504b4efa4',
    messagingSenderId: '1064202474797',
    projectId: 'pokemon-3172d',
    storageBucket: 'pokemon-3172d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxDcvHpX8j7wCxrDWM76YhzZxScKjVHhY',
    appId: '1:1064202474797:ios:402f84659342a75eb4efa4',
    messagingSenderId: '1064202474797',
    projectId: 'pokemon-3172d',
    storageBucket: 'pokemon-3172d.firebasestorage.app',
    iosBundleId: 'com.example.pokemon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxDcvHpX8j7wCxrDWM76YhzZxScKjVHhY',
    appId: '1:1064202474797:ios:402f84659342a75eb4efa4',
    messagingSenderId: '1064202474797',
    projectId: 'pokemon-3172d',
    storageBucket: 'pokemon-3172d.firebasestorage.app',
    iosBundleId: 'com.example.pokemon',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDr8b0Fz5b9ihd2KjWjGrohUdBvJf4zVoI',
    appId: '1:1064202474797:web:f5929c6bfaac94d3b4efa4',
    messagingSenderId: '1064202474797',
    projectId: 'pokemon-3172d',
    authDomain: 'pokemon-3172d.firebaseapp.com',
    storageBucket: 'pokemon-3172d.firebasestorage.app',
    measurementId: 'G-5XEY95681W',
  );
}
