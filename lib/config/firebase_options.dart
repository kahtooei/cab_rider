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
        return macos;
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
    apiKey: 'AIzaSyAnMPQl0jgv_RWoAYYyYgGx-EKld0PRVpY',
    appId: '1:263838883666:web:18351422ff0dd87f68648b',
    messagingSenderId: '263838883666',
    projectId: 'free-projects-55c94',
    authDomain: 'free-projects-55c94.firebaseapp.com',
    storageBucket: 'free-projects-55c94.appspot.com',
    measurementId: 'G-F9SNT07EX1',
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyBYk_1szBMkLknoWW4RaS19IocGbwtozKQ',
      appId: '1:263838883666:android:4bc74009fde1242c68648b',
      messagingSenderId: '263838883666',
      projectId: 'free-projects-55c94',
      storageBucket: 'free-projects-55c94.appspot.com',
      databaseURL:
          'https://free-projects-55c94-default-rtdb.asia-southeast1.firebasedatabase.app');

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5ahI-gHKkTb7dWUKNCE8Dkx0on4JXH1g',
    appId: '1:263838883666:ios:95b8bdb92ae1222368648b',
    messagingSenderId: '263838883666',
    projectId: 'free-projects-55c94',
    storageBucket: 'free-projects-55c94.appspot.com',
    iosClientId:
        '263838883666-jmfonpkjbssme77g2tvnlqsv973gh492.apps.googleusercontent.com',
    iosBundleId: 'com.kahtooei.cabRider',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5ahI-gHKkTb7dWUKNCE8Dkx0on4JXH1g',
    appId: '1:263838883666:ios:95b8bdb92ae1222368648b',
    messagingSenderId: '263838883666',
    projectId: 'free-projects-55c94',
    storageBucket: 'free-projects-55c94.appspot.com',
    iosClientId:
        '263838883666-jmfonpkjbssme77g2tvnlqsv973gh492.apps.googleusercontent.com',
    iosBundleId: 'com.kahtooei.cabRider',
  );
}
