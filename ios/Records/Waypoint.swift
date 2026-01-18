import ExpoModulesCore

struct Waypoint: Record {
  @Field
  var coordinate: GeographicCoordinate = GeographicCoordinate()

  @Field
  var kind: WaypointKind = .break_
}
