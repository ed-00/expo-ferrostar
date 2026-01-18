import ExpoModulesCore

struct Speed: Record {
  @Field
  var value: Double = 0.0
  
  @Field
  var accuracy: Double?
}
