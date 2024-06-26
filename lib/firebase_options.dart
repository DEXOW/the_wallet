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
    apiKey: 'AIzaSyCYGSu1oYUAJi43ZAmO94sOWDMWfRhbGj8',
    appId: '1:277225708946:android:ad36ed28c820da34c6354b',
    messagingSenderId: '277225708946',
    projectId: 'the-wallet-2fa7c',
    databaseURL: 'https://the-wallet-2fa7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'the-wallet-2fa7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBKr0SieJMJ0rz6kmdMVwM0wR5nX-6PLo',
    appId: '1:277225708946:ios:6ba30ee575b0d46fc6354b',
    messagingSenderId: '277225708946',
    projectId: 'the-wallet-2fa7c',
    databaseURL: 'https://the-wallet-2fa7c-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'the-wallet-2fa7c.appspot.com',
    androidClientId: '277225708946-0rbln2gkn6tlkvmok9um8eng6fgj1g97.apps.googleusercontent.com',
    iosClientId: '277225708946-a7m870sqe4d0670v9vdllbgjbcehnf94.apps.googleusercontent.com',
    iosBundleId: 'com.example.theWallet',
  );
}
