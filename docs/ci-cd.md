# CI/CD setup

This project uses GitHub Actions for Flutter validation and Android release delivery.

## Workflows

- `.github/workflows/ci.yml`
  Runs on pushes to `main`, `master`, and `develop`, plus all pull requests.
  It installs Flutter, runs `flutter analyze`, and runs `flutter test`.

- `.github/workflows/release-android.yml`
  Runs on tags that match `v*` and can also be started manually from the Actions tab.
  It rebuilds the Android signing files from GitHub Secrets, builds a signed `.aab`, uploads it as an artifact, and can deploy to the Google Play internal track.

## Required GitHub Secrets

Add these repository secrets before using the release workflow:

- `ANDROID_KEYSTORE_BASE64`: base64-encoded contents of `android/app/upload-keystore.jks`
- `ANDROID_KEY_ALIAS`: keystore alias, for example `upload`
- `ANDROID_KEY_PASSWORD`: key password
- `ANDROID_STORE_PASSWORD`: keystore password

Optional secret for Play Store deployment:

- `PLAY_STORE_SERVICE_ACCOUNT_JSON`: Google Play service account JSON with permission to manage releases

## How to create the keystore secret

Run this locally from the repository root:

```bash
base64 -i android/app/upload-keystore.jks | pbcopy
```

Then paste the copied value into the `ANDROID_KEYSTORE_BASE64` secret in GitHub.

## Release flow

1. Push changes to a branch and open a pull request.
2. Wait for the `Flutter CI` workflow to pass.
3. Merge to your main branch.
4. Create and push a tag like `v1.0.0`.
5. The `Android Release` workflow builds a signed bundle.
6. If `PLAY_STORE_SERVICE_ACCOUNT_JSON` is configured, the workflow also deploys to the internal testing track.

## Manual release

You can also trigger `Android Release` manually and choose whether to deploy to Play Store immediately.

## Notes

- The workflow recreates `android/key.properties` during the run, so that file stays local and out of git.
- If you only want build artifacts and not automatic Play Store deployment, leave `PLAY_STORE_SERVICE_ACCOUNT_JSON` unset.
