
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyA7Kn5N7o5seFzmhlY2yNikNadQ4kct8qA',
    appId: '1:616276307384:web:3fdb91c8aa7b81b135334d',
    messagingSenderId: '616276307384',
    projectId: 'attendance-e3fe8',
    authDomain: 'attendance-e3fe8.firebaseapp.com',
    storageBucket: 'attendance-e3fe8.appspot.com',
    measurementId: 'G-SN2F3CNXGJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBLLI7TyWt6TdtlqxWJrcePxDOHfT5geI',
    appId: '1:616276307384:android:d1d9bc3ea7137a8c35334d',
    messagingSenderId: '616276307384',
    projectId: 'attendance-e3fe8',
    storageBucket: 'attendance-e3fe8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlJ1hS_a0awskukJFVcnlbVUJOUkMx8BU',
    appId: '1:616276307384:ios:1f22dc0da4ec977a35334d',
    messagingSenderId: '616276307384',
    projectId: 'attendance-e3fe8',
    storageBucket: 'attendance-e3fe8.appspot.com',
    iosBundleId: 'com.example.flutterDev',
  );
}
