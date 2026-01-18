import { Ferrostar, Route, UserLocation, Waypoint } from "expo-ferrostar";
import { SafeAreaView, View, Button, Alert } from "react-native";
import { useRef } from "react";

export default function App() {
  const ferrostarRef = useRef<any>(null); // Use proper type if available

  const handleStart = async () => {
    // Mock data for testing
    const location: UserLocation = {
      coordinates: { lat: 37.7749, lng: -122.4194 },
      horizontalAccuracy: 10,
      timestamp: new Date().toISOString(),
    };
    const waypoints: Waypoint[] = [
      { coordinate: { lat: 34.0522, lng: -118.2437 }, kind: "break" }
    ];

    try {
      const routes = await ferrostarRef.current?.getRoutes(location, waypoints);
      console.log("Routes:", routes);
      if (routes && routes.length > 0) {
        ferrostarRef.current?.startNavigation(routes[0]);
      } else {
        Alert.alert("No routes found");
      }
    } catch (e) {
      console.error(e);
      Alert.alert("Error", String(e));
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.controls}>
        <Button title="Get Routes & Start" onPress={handleStart} />
        <Button title="Stop" onPress={() => ferrostarRef.current?.stopNavigation()} />
      </View>
      <Ferrostar
        ref={ferrostarRef}
        style={{ flex: 1, width: "100%" }}
        coreOptions={{
          valhallaEndpointURL: "https://api.stadiamaps.com/route/v1",
          profile: "bicycle"
        }}
      />
    </SafeAreaView>
  );
}

const styles = {
  container: {
    flex: 1,
    backgroundColor: "#eee",
  },
  controls: {
    padding: 10,
    flexDirection: "row" as "row", // Fix type inference
    justifyContent: "space-around" as "space-around",
    backgroundColor: '#fff'
  }
};
