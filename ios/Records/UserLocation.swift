import ExpoModulesCore

struct UserLocation: Record {
  @Field
  var coordinates: GeographicCoordinate = GeographicCoordinate()
  
  @Field
  var horizontalAccuracy: Double = 0.0
  
  @Field
  var courseOverGround: CourseOverGround?
  
  @Field
  var timestamp: String = ""
  
  @Field
  var speed: Speed?
}
