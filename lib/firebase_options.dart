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
    apiKey: 'AIzaSyCeR0PTbWe6mdKfiHCZ8m2gZjxsAbV_N_o',
    appId: '1:971989402381:web:c3503a4128f768964ae644',
    messagingSenderId: '971989402381',
    projectId: 'fir-d4b70',
    authDomain: 'fir-d4b70.firebaseapp.com',
    storageBucket: 'fir-d4b70.firebasestorage.app',
    measurementId: 'G-MNS0EFBD07',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkO6Ezq4GtzzQ5tT2Me7REL67Phh46n6Y',
    appId: '1:971989402381:android:bd01ec85d82ea9434ae644',
    messagingSenderId: '971989402381',
    projectId: 'fir-d4b70',
    storageBucket: 'fir-d4b70.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLVljxr3tGY6h0fgoso5oV_Z6Yn0IgHRU',
    appId: '1:971989402381:ios:9ae80d3dc23d9d3f4ae644',
    messagingSenderId: '971989402381',
    projectId: 'fir-d4b70',
    storageBucket: 'fir-d4b70.firebasestorage.app',
    iosBundleId: 'com.example.mad2414',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLVljxr3tGY6h0fgoso5oV_Z6Yn0IgHRU',
    appId: '1:971989402381:ios:9ae80d3dc23d9d3f4ae644',
    messagingSenderId: '971989402381',
    projectId: 'fir-d4b70',
    storageBucket: 'fir-d4b70.firebasestorage.app',
    iosBundleId: 'com.example.mad2414',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCeR0PTbWe6mdKfiHCZ8m2gZjxsAbV_N_o',
    appId: '1:971989402381:web:edab378f289c65974ae644',
    messagingSenderId: '971989402381',
    projectId: 'fir-d4b70',
    authDomain: 'fir-d4b70.firebaseapp.com',
    storageBucket: 'fir-d4b70.firebasestorage.app',
    measurementId: 'G-HSLQQ60F50',
  );
}
