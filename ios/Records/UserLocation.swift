import ExpoModulesCore

struct Speed: Record {
  @Field
  var value: Double = 0.0
  
  @Field
  var accuracy: Double?
}

struct CourseOverGround: Record {
  @Field
  var degrees: Double = 0.0
  
  @Field
  var accuracy: Double?
}

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
