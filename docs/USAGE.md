# Usage Guide

## Basic Setup

Wrap your application or screen with the necessary layout.

```tsx
import { Ferrostar, FerrostarRef } from "expo-ferrostar";
import { useRef } from "react";

export default function NavigationScreen() {
  const ferrostarRef = useRef<FerrostarRef>(null);

  return (
    <Ferrostar
      ref={ferrostarRef}
      style={{ flex: 1 }}
      coreOptions={{
        valhallaEndpointURL: "https://api.stadiamaps.com/route/v1?api_key=YOUR_KEY",
        profile: "auto",
        locationMode: "default"
      }}
    />
  );
}
```

## Calculating a Route

You need a start location and at least one destination waypoint.

```tsx
const calculateRoute = async () => {
  const userLocation = {
    coordinates: { lat: 52.52, lng: 13.405 },
    horizontalAccuracy: 5,
    timestamp: new Date().toISOString()
  };

  const waypoints = [
    { 
      coordinate: { lat: 52.51, lng: 13.38 }, 
      kind: "break" 
    }
  ];

  try {
    const routes = await ferrostarRef.current?.getRoutes(userLocation, waypoints);
    console.log("Found routes:", routes);
    return routes?.[0];
  } catch (error) {
    console.error("Routing failed:", error);
  }
};
```

## Starting Navigation

Once you have a route, pass it to `startNavigation`.

```tsx
const start = async () => {
  const route = await calculateRoute();
  if (route) {
    ferrostarRef.current?.startNavigation(route, {
       stepAdvance: {
         minimumHorizontalAccuracy: 10,
         automaticAdvanceDistance: 10
       },
       routeDeviationTracking: {
         minimumHorizontalAccuracy: 15,
         maxAcceptableDeviation: 25
       }
    });
  }
};
```
