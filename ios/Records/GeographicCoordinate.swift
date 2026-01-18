import ExpoModulesCore

struct GeographicCoordinate: Record {
  @Field
  var lat: Double = 0.0

  @Field
  var lng: Double = 0.0
}
