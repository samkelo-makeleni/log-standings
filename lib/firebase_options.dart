import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Firebase configuration for different platforms
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  /// Firebase options for Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkLSCbi8VHdGhmUH_QMMM4UJ993TLRU7A',
    appId: '1:704549837314:android:3116a526c301e45007251b',
    messagingSenderId: '704549837314',
    projectId: 'tshwane-reginal-football',
    storageBucket: 'tshwane-reginal-football.firebasestorage.app',
  );

  /// Firebase options for iOS - Update with your iOS credentials from GoogleService-Info.plist
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
    projectId: 'tshwane-reginal-football',
    storageBucket: 'tshwane-reginal-football.firebasestorage.app',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  /// Firebase options for Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    appId: 'YOUR_WEB_APP_ID',
    messagingSenderId: 'YOUR_WEB_MESSAGING_SENDER_ID',
    projectId: 'tshwane-reginal-football',
    authDomain: 'YOUR_AUTH_DOMAIN',
    storageBucket: 'tshwane-reginal-football.firebasestorage.app',
  );
}
