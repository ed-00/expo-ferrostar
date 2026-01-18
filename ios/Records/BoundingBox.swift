import ExpoModulesCore

struct BoundingBox: Record {
  @Field
  var ne: GeographicCoordinate = GeographicCoordinate()

  @Field
  var sw: GeographicCoordinate = GeographicCoordinate()
}
