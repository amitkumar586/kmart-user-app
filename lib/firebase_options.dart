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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCIlAaHDqnetPtHjlUADNoWjvfCFlqX_WU',
    appId: '1:573732244427:web:91656e1bd21b30afe9c44e',
    messagingSenderId: '573732244427',
    projectId: 'kmart-2c7fd',
    authDomain: 'kmart-2c7fd.firebaseapp.com',
    storageBucket: 'kmart-2c7fd.appspot.com',
    measurementId: 'G-EKPL0KDW5D',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyKzX1n1p-igX8LZ0uQuUdU5gRxSNhfSY',
    appId: '1:573732244427:android:15052d9da4c4b073e9c44e',
    messagingSenderId: '573732244427',
    projectId: 'kmart-2c7fd',
    storageBucket: 'kmart-2c7fd.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNX2sE2gTbAdlvSC63DZvXfoHsVKH4VW8',
    appId: '1:573732244427:ios:07a0cd031d534e1ee9c44e',
    messagingSenderId: '573732244427',
    projectId: 'kmart-2c7fd',
    storageBucket: 'kmart-2c7fd.appspot.com',
    iosBundleId: 'com.example.kmart',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNX2sE2gTbAdlvSC63DZvXfoHsVKH4VW8',
    appId: '1:573732244427:ios:07a0cd031d534e1ee9c44e',
    messagingSenderId: '573732244427',
    projectId: 'kmart-2c7fd',
    storageBucket: 'kmart-2c7fd.appspot.com',
    iosBundleId: 'com.example.kmart',
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCIlAaHDqnetPtHjlUADNoWjvfCFlqX_WU',
    appId: '1:573732244427:web:dadcd6f3b6d0759fe9c44e',
    messagingSenderId: '573732244427',
    projectId: 'kmart-2c7fd',
    authDomain: 'kmart-2c7fd.firebaseapp.com',
    storageBucket: 'kmart-2c7fd.appspot.com',
    measurementId: 'G-WV327ZC93B',
  );
}
