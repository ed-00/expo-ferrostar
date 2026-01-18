import ExpoModulesCore

struct StaticThreshold: Record {
  @Field
  var minimumHorizontalAccuracy: Double = 0.0
  
  @Field
  var maxAcceptableDeviation: Double = 0.0
}
