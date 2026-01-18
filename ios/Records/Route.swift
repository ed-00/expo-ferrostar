import ExpoModulesCore

struct Route: Record {
  @Field
  var geometry: [GeographicCoordinate] = []
  
  @Field
  var bbox: BoundingBox = BoundingBox()
  
  @Field
  var distance: Double = 0.0
  
  @Field
  var waypoints: [Waypoint] = []
  
  @Field
  var steps: [RouteStep] = []
}
