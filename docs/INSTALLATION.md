# Installation Guide

## Prerequisites

- **Expo**: SDK 49+ recommended.
- **Platforms**: 
  - Android (min SDK 26)
  - iOS (min iOS 16.0)

## Step 1: Install Package

Add the dependency to your project:

```bash
npm install expo-ferrostar
# or
npx expo install expo-ferrostar
```

## Step 2: iOS Configuration (Crucial)

Ferrostar is distributed as a Swift Package. Since Expo Modules rely on CocoaPods, you must manually link the Swift Package in your Xcode project.

> **Note**: This step is required every time you regenerate your iOS project (e.g., deleting `ios` folder).

1.  **Generate Native Project**:
    ```bash
    npx expo prebuild --platform ios
    ```
2.  **Open Xcode**:
    ```bash
    xed ios
    ```
3.  **Add Package Dependency**:
    - Go to **File** > **Add Packages...**
    - Enter URL: `https://github.com/stadiamaps/ferrostar`
    - Click **Add Package**.
4.  **Link Frameworks**:
    - Select your App Target (not the Pods target).
    - Go to **General** > **Frameworks, Libraries, and Embedded Content**.
    - Click **+**.
    - Select `FerrostarCore` and `FerrostarMapLibreUI`.
    - Ensure "Embed & Sign" is selected.

5.  **Troubleshooting Build Errors**:
    - If you encounter a `Sandbox: bash deny file-read-data` error:
        - Go to **Build Settings** in Xcode.
        - Search for `User Script Sandboxing`.
        - Set it to **No** for both the **Project** and the **Target**.

## Step 3: Android Configuration

Android configuration is generally automatic via Gradle.

- Ensure your `android/build.gradle` defines `minSdkVersion` 26 or higher.

## Step 4: Permissions

### iOS (`Info.plist`)
Add usage descriptions for location services to your `app.json` or `Info.plist`:

- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysAndWhenInUseUsageDescription` (if background navigation is needed)
- `UIBackgroundModes` -> `location` (for background navigation)

### Android (`AndroidManifest.xml`)
The library requests necessary permissions, but ensure you handle runtime permission requests in your React Native app (using `expo-location` or similar).

- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
