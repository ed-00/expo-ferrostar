import ExpoModulesCore

struct CourseOverGround: Record {
  @Field
  var degrees: Double = 0.0
  
  @Field
  var accuracy: Double?
}
