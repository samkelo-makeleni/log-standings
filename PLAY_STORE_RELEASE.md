# Play Store release notes

## App identity

- App name: `TR_FOOTBALL`
- Package name: `com.samkelomakeleni.logstandings`
- Version: `1.0.0+1`

## Signing setup

- Upload keystore: `android/app/upload-keystore.jks`
- Gradle signing config: `android/app/build.gradle.kts`
- Local signing properties: `android/key.properties`

SHA-1 certificate fingerprint:

`28:AF:2C:F9:7D:D5:3C:E2:8F:EA:D2:46:6E:19:D7:94:08:C1:2C:94`

SHA-256 certificate fingerprint:

`33:6D:90:43:3E:19:26:63:44:C9:4B:61:0E:73:DD:B8:FF:61:0F:CA:1A:76:A7:74:1F:9C:D0:28:E8:84:04:0A`

## Build command

```bash
flutter build appbundle --release
```

Expected artifact:

`build/app/outputs/bundle/release/app-release.aab`

## Play Console checklist

- Create or open the app in Google Play Console.
- Set the store listing title to `TR_FOOTBALL`.
- Add the short description and full description.
- Upload the app icon, feature graphic, and screenshots.
- Complete the App content questionnaires.
- Create a production release and upload the `.aab` bundle.
- If Google Play App Signing is offered, keep it enabled and upload with this keystore.

## Important

- `android/key.properties` and `android/app/upload-keystore.jks` are ignored by git.
- Back up both files securely before publishing. You need them for future updates unless you rotate your upload key in Play Console.
