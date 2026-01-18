# API Reference

## Components

### `<Ferrostar />`

The main view component for rendering the map and navigation UI.

```tsx
<Ferrostar 
  ref={ref}
  style={styles.map}
  coreOptions={coreOptions}
  navigationOptions={navigationOptions}
/>
```

#### Props

- **`style`**: `ViewStyle` - Standard React Native style.
- **`coreOptions`**: `FerrostarCoreOptions` - Configuration for the underlying Ferrostar Core.
- **`navigationOptions`**: `FerrostarNavigationOptions` - Configuration for the Navigation View UI.

## Types

### `FerrostarCoreOptions`

| Property | Type | Description |
|----------|------|-------------|
| `valhallaEndpointURL` | `string` | URL of the Valhalla routing engine (e.g. Stadia Maps API). |
| `profile` | `string` | Routing profile: `bicycle`, `auto`, `pedestrian`, etc. |
| `locationMode` | `LocationMode` | `.fused`, `.default`, `.simulated`. |
| `navigationControllerConfig` | `NavigationControllerConfig` | Advanced controller settings. |

### `FerrostarNavigationOptions`

| Property | Type | Description |
|----------|------|-------------|
| `styleUrl` | `string` | URL for the MapLibre style JSON. |
| `snapUserLocationRoute` | `boolean` | Whether to snap the puck to the route line. |

## Methods

Accessed via `ref`.

### `getRoutes(initialLocation, waypoints)`

Calculates routes between points.

- **Returns**: `Promise<Route[]>`

### `startNavigation(route, config)`

Starts the turn-by-turn navigation session.

- **route**: `Route` object returned from `getRoutes`.
- **config**: (Optional) `NavigationControllerConfig`.

### `stopNavigation()`

Stops the current navigation session.

### `replaceRoute(route, config)`

Replaces the current active route (e.g. after recalculation).

### `advanceToNextStep()`

Manually advances to the next instruction step (mostly for testing/simulation).
