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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC_ubN3n0_aJZAugjyEeVWPy-CwD1H5nK4',
    appId: '1:599030350718:web:ca91f6b1d6769be8b6292f',
    messagingSenderId: '599030350718',
    projectId: 'fir-auth-demo-ec48c',
    authDomain: 'fir-auth-demo-ec48c.firebaseapp.com',
    storageBucket: 'fir-auth-demo-ec48c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_f7VJjRvB08PFP0eJw5bsDwQXBOtkDp4',
    appId: '1:336552091022:android:d468161f768dc8e287d8df',
    messagingSenderId: '336552091022',
    projectId: 'finaly-auth-gym-app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9wBMEJ1WDl8WkUoxHqIVqPLvwClaTYxs',
    appId: '1:599030350718:ios:d4aadf3cf97a599eb6292f',
    messagingSenderId: '599030350718',
    projectId: 'fir-auth-demo-ec48c',
    storageBucket: 'fir-auth-demo-ec48c.appspot.com',
    iosClientId:
        '599030350718-rt5diuiggpna5fmco6k05teqm2km0f66.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthDemo',
  );
}
