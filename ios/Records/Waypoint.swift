import ExpoModulesCore

enum WaypointKind: String, Enumerable {
  case break_ = "break"
  case via
}

struct Waypoint: Record {
  @Field
  var coordinate: GeographicCoordinate = GeographicCoordinate()

  @Field
  var kind: WaypointKind = .break_
}
