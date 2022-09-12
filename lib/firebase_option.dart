import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:getxfire/getxfire.dart';

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
      case TargetPlatform.fuchsia:
        return fuchsia;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not support for this platform.');
    }
  }

  static FirebaseOptions get web => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get android => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get ios => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get macos => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get windows => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get fuchsia => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);

  static FirebaseOptions get linux => FirebaseOptions(
      apiKey: firebaseOptions.apiKey,
      appId: firebaseOptions.appId,
      messagingSenderId: firebaseOptions.messagingSenderId,
      projectId: firebaseOptions.projectId);
}

FirebaseOptions get firebaseOptions {
  return const FirebaseOptions(
      apiKey: 'AIzaSyAypBObLlTSZAeu8gs7Km3pWW-RCxk7ywc',
      appId: '1:55611526582:android:d50936ec4e0738a5080517',
      messagingSenderId: '55611526582',
      projectId: 'egoteback',
      authDomain: 'https://storage.googleapis.com',
      storageBucket: 'egoteback.appspot.com',
      databaseURL:
          'https://console.cloud.google.com/storage/browser/egoteback.appspot.com',
      deepLinkURLScheme:
          'https://egoteback-default-rtdb.europe-west1.firebasedatabase.app/');
}
