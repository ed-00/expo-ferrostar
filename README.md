# Expo Ferrostar

An Expo module that integrates the [Ferrostar](https://github.com/stadiamaps/ferrostar) navigation SDK (by Stadia Maps) into your React Native / Expo application. 

This module supports both **Android** and **iOS**, providing a unified TypeScript API for turn-by-turn navigation, route generation, and custom navigation views.

## Features

- 🗺️ **Unified Maps**: Integrates MapLibre via Ferrostar's UI components.
- 📍 **Routing**: Fetch routes including waypoints, instructions, and geometry.
- 🚗 **Navigation**: Full turn-by-turn state machine (start, stop, progress updates).
- 🎨 **Customizable**: Configure styles, profiles (bicycle, auto, pedestrian), and location providers.

---

## Installation

### 1. Install the package

```sh
npm install expo-ferrostar
# or
npx expo install expo-ferrostar
```

### 2. Platform Specific Setup

#### Android
No additional setup is usually required. The module uses `gradle` dependencies which strictly resolve the native Ferrostar Android SDK.

*Compatible with Android SDK 26+*

#### iOS

> [!IMPORTANT]
> **Manual Step Required**: Ferrostar is distributed as a Swift Package, while Expo Modules rely on CocoaPods. You must manually link the specific Ferrostar Swift Package in your Xcode project.

1.  Run `npx expo prebuild` (if using CNG/Managed workflow, this creates the `ios` folder).
2.  Open your `ios/YourAppName.xcworkspace` in Xcode.
3.  Go to **File** > **Add Packages...**
4.  Enter the Ferrostar Repository URL: `https://github.com/stadiamaps/ferrostar`
5.  Add the package to your project's main target (not the `ExpoFerrostar` target).
6.  Ensure `FerrostarCore` and `FerrostarMapLibreUI` are included in your target's **Frameworks, Libraries, and Embedded Content**.

*Compatible with iOS 16.0+*

---

## Usage

### Basic Component

Render the navigation map view.

```tsx
import { Ferrostar } from "expo-ferrostar";
import { StyleSheet, View } from "react-native";

export default function App() {
  return (
    <View style={styles.container}>
      <Ferrostar 
        style={styles.map} 
        coreOptions={{
            valhallaEndpointURL: "https://api.stadiamaps.com/route/v1",
            profile: "bicycle"
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1 },
  map: { flex: 1, width: "100%" }
});
```

### API Reference

#### Types

- `UserLocation`: `{ coordinates: GeographicCoordinate, horizontalAccuracy: number, ... }`
- `Waypoint`: `{ coordinate: GeographicCoordinate, kind: "break" | "via" }`
- `Route`: The calculated route object returned by `getRoutes`.

#### Core Methods

To access imperative methods (like fetch routes or starting navigation), you must access the component via a `ref`.

```tsx
import { useRef } from "react";
import { Ferrostar, FerrostarRef } from "expo-ferrostar";

// ... inside component
const ferrostarRef = useRef<FerrostarRef>(null);

// 1. Get Routes
const routes = await ferrostarRef.current?.getRoutes(
    userLocation, 
    [destinationWaypoint]
);

// 2. Start Navigation
if (routes && routes.length > 0) {
    ferrostarRef.current?.startNavigation(
        routes[0], 
        { 
            stepAdvance: { minimumHorizontalAccuracy: 20 },
            routeDeviationTracking: { maxAcceptableDeviation: 25 }
        }
    );
}

// 3. Stop Navigation
ferrostarRef.current?.stopNavigation();
```

---

## Development & Contributing

This project is a local Expo Module. 

- **Build iOS**: `cd example/ios && pod install && xed .`
- **Build Android**: Open `android` folder in Android Studio.
- **Scripts**:
    - `npm run build`: Builds the TypeScript code.
    - `npm run clean`: Cleans build artifacts.

---

**Note**: This library is a wrapper and depends on the specific API surfaces of the native options. Please refer to [Ferrostar Native Docs](https://stadiamaps.github.io/ferrostar/) for deep dives into configuration values.
