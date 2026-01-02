// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// DefaultFirebaseOptions
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
        throw UnsupportedError('Windows belum didukung');
      case TargetPlatform.linux:
        throw UnsupportedError('Linux belum didukung');
      default:
        throw UnsupportedError('Platform tidak dikenali');
    }
  }

  // Web (PWA) – wajib diisi
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAECKlV3E_GMIrUlN7WOU7i-u0iyEOmHaA',
    appId: '1:656359052966:web:4335494b3446f63f1ec667',
    messagingSenderId: '656359052966',
    projectId: 'el-traco',
    authDomain: 'el-traco.firebaseapp.com',
    storageBucket: 'el-traco.firebasestorage.app',
    measurementId: 'G-2R4GJWXGXQ', // optional
  );

  // Android (opsional, kosongkan saja kalau tidak pakai)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  // iOS (opsional)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );

  // macOS (opsional)
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
  );
}
