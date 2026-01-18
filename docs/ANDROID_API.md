# Ferrostar Android Implementation Reference

This document details the existing Android implementation of the `expo-ferrostar` module. It serves as a reference for the iOS implementation and general usage.

## Module Configuration

- **Name**: `ExpoFerrostar`
- **Package**: `expo.modules.ferrostar`

## Native View

### `ExpoFerrostarView`

A Compose-based view that renders the Ferrostar `NavigationScene`.

**Props:**

1.  **`navigationOptions`** (`FerrostarNavigationOptions`)
    - Configures the visual appearance and behavior of the navigation view.
2.  **`coreOptions`** (`FerrostarCoreOptions`)
    - Configures the underlying `FerrostarCore` instance.
    - Changes to this prop trigger a core update (`updateCore()`), re-initializing `FerrostarCore`.

**Events:**

1.  **`onNavigationStateChange`**
    - Payload: `{ isNavigating: boolean, isCalculatingNewRoute: boolean }`
    - Emitted when the navigation state changes in `DefaultNavigationViewModel`.

## Async Methods (Module & View)

The module exposes methods that operate on the `ExpoFerrostarView`.

### 1. `getRoutes(initialLocation, waypoints)`
- **Arguments**:
    - `initialLocation`: `UserLocation`
    - `waypoints`: `List<Waypoint>`
- **Returns**: `Promise<List<Route>>`
- **Description**: Calculates routes using the underlying `FerrostarCore`.
- **Note**: The returned routes are mapped from `uniffi.ferrostar.Route` to the local `Route` record type.

### 2. `startNavigation(route, options)`
- **Arguments**:
    - `route`: `Route`
    - `options`: `NavigationControllerConfig?`
- **Description**: Starts the navigation session with the provided route and configuration.

### 3. `stopNavigation(stopLocationUpdates)`
- **Arguments**:
    - `stopLocationUpdates`: `Boolean?`
- **Description**: Stops the current navigation session.

### 4. `replaceRoute(route, options)`
- **Arguments**:
    - `route`: `Route`
    - `options`: `NavigationControllerConfig?`
- **Description**: Replaces the currently active route.

### 5. `advanceToNextStep()`
- **Description**: Manually advances the navigation to the next step.

## Data Types (Records)

The following data structures (Records) are defined and shared between JS and Native:

### Core Types
- **`GeographicCoordinate`**: `{ lat: Double, lng: Double }`
- **`BoundingBox`**: `{ ne: GeographicCoordinate, sw: GeographicCoordinate }`
- **`Waypoint`**: `{ coordinate: GeographicCoordinate, kind: WaypointKind }`
- **`UserLocation`**: `{ coordinates: GeographicCoordinate, horizontalAccuracy: Double, courseOverGround: CourseOverGround?, timestamp: String, speed: Speed? }`

### Route Types
- **`Route`**:
    - `geometry`: `List<GeographicCoordinate>`
    - `bbox`: `BoundingBox`
    - `distance`: `Double`
    - `waypoints`: `List<Waypoint>`
    - `steps`: `List<RouteStep>`
- **`RouteStep`**:
    - `geometry`: `List<GeographicCoordinate>`
    - `distance`: `Double`
    - `duration`: `Double`
    - `roadName`: `String?`
    - `instruction`: `String`
    - `visualInstructions`: `List<VisualInstruction>`
    - `spokenInstructions`: `List<SpokenInstruction>`
    - `annotation`: `List<String>` (Note: Mapped from `annotations` in Kotlin?)

### Navigation/Core Options
- **`FerrostarCoreOptions`**:
    - `locationMode`: `LocationMode` (FUSED, DEFAULT, SIMULATED)
    - `valhallaEndpointURL`: `String?`
    - `profile`: `String?`
    - `options`: `Map<String, Any>?`
    - `navigationControllerConfig`: `NavigationControllerConfig`
- **`FerrostarNavigationOptions`**:
    - `styleUrl`: `String?`
    - `snapUserLocationToRoute`: `Boolean?`

### Instructions
- **`VisualInstruction`**: `{ primaryContent, secondaryContent, subContent, triggerDistanceBeforeManeuver }`
- **`VisualInstructionContent`**: `{ text, maneuverType, maneuverModifier, roundaboutExitDegrees, laneInfo }`
- **`SpokenInstruction`**: `{ text, ssml, triggerDistanceBeforeManeuver, utteranceId }`

## Usage Example (Conceptual)

```typescript
import { Ferrostar, Route, UserLocation, Waypoint } from 'expo-ferrostar';

const MyNavigationComponent = () => {
  const ferrostarRef = useRef<Ferrostar>(null);

  const handleGetRoutes = async () => {
    const location: UserLocation = { ... };
    const waypoints: Waypoint[] = [ ... ];
    const routes = await ferrostarRef.current?.getRoutes(location, waypoints);
    if (routes && routes.length > 0) {
      ferrostarRef.current?.startNavigation(routes[0]);
    }
  };

  return (
    <Ferrostar
      ref={ferrostarRef}
      style={{ flex: 1 }}
      coreOptions={{
        valhallaEndpointURL: "https://api.stadiamaps.com/route/v1",
        profile: "bicycle",
      }}
      onNavigationStateChange={(event) => {
        console.log("Is Navigating:", event.nativeEvent.isNavigating);
      }}
    />
  );
};
```
