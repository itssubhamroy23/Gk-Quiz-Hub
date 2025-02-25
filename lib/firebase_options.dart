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
    apiKey: 'AIzaSyDAdkAWxETLpFZyDdw_NKE13rM2vdxIU7U',
    appId: '1:276782761060:web:3222c18846d6a81fb84b71',
    messagingSenderId: '276782761060',
    projectId: 'gk-quiz-hub-8f714',
    authDomain: 'gk-quiz-hub-8f714.firebaseapp.com',
    storageBucket: 'gk-quiz-hub-8f714.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGGutIwijfKEUfG4FnGuyLEXEPMig4Hus',
    appId: '1:276782761060:android:6d63f78d935cb74ab84b71',
    messagingSenderId: '276782761060',
    projectId: 'gk-quiz-hub-8f714',
    storageBucket: 'gk-quiz-hub-8f714.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPVLGQQv1QotebWE21s0a3UmnMnWDDgxs',
    appId: '1:276782761060:ios:61fc4ce83ce20f4bb84b71',
    messagingSenderId: '276782761060',
    projectId: 'gk-quiz-hub-8f714',
    storageBucket: 'gk-quiz-hub-8f714.appspot.com',
    iosBundleId: 'com.app.gkquiz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPVLGQQv1QotebWE21s0a3UmnMnWDDgxs',
    appId: '1:276782761060:ios:61fc4ce83ce20f4bb84b71',
    messagingSenderId: '276782761060',
    projectId: 'gk-quiz-hub-8f714',
    storageBucket: 'gk-quiz-hub-8f714.appspot.com',
    iosBundleId: 'com.app.gkquiz',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAdkAWxETLpFZyDdw_NKE13rM2vdxIU7U',
    appId: '1:276782761060:web:82d65c1cf5d41c77b84b71',
    messagingSenderId: '276782761060',
    projectId: 'gk-quiz-hub-8f714',
    authDomain: 'gk-quiz-hub-8f714.firebaseapp.com',
    storageBucket: 'gk-quiz-hub-8f714.appspot.com',
  );
}
