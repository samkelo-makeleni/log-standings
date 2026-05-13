import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

/// Firebase configuration for different platforms
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      _ensureConfigured(
        platformName: 'web',
        requiredValues: [
          web.apiKey,
          web.appId,
          web.messagingSenderId,
          web.authDomain,
        ],
      );
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        _ensureConfigured(
          platformName: 'iOS',
          requiredValues: [
            ios.apiKey,
            ios.appId,
            ios.messagingSenderId,
            ios.iosBundleId,
          ],
        );
        return ios;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Firebase is configured only for Android, iOS, and web.',
        );
      case TargetPlatform.fuchsia:
        throw UnsupportedError('Firebase is not configured for Fuchsia.');
    }
  }

  static void _ensureConfigured({
    required String platformName,
    required List<String?> requiredValues,
  }) {
    final hasPlaceholder = requiredValues.any(
      (value) => value == null || value.isEmpty || value.startsWith('YOUR_'),
    );

    if (hasPlaceholder) {
      throw UnsupportedError(
        'Firebase $platformName configuration is incomplete. '
        'Run `flutterfire configure` to update lib/firebase_options.dart.',
      );
    }
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
    apiKey: 'AIzaSyAuBecdfIbcs53aMz1oDBZOrRNMwzmEQbY',
    appId: '1:704549837314:ios:9bb937f3498a7eac07251b',
    messagingSenderId: '704549837314',
    projectId: 'tshwane-reginal-football',
    storageBucket: 'tshwane-reginal-football.firebasestorage.app',
    iosBundleId: 'com.samkelomakeleni.logstandings',
  );

  /// Firebase options for Web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBTroh9OrkcUwpfllpBSYmkIjnLeE1XKSA',
    appId: '1:704549837314:web:8159d401ceefdf0e07251b',
    messagingSenderId: '704549837314',
    projectId: 'tshwane-reginal-football',
    authDomain: 'tshwane-reginal-football.firebaseapp.com',
    storageBucket: 'tshwane-reginal-football.firebasestorage.app',
    measurementId: 'G-9RFYMZKR1N',
  );
}
