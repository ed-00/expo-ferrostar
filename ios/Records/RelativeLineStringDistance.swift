import ExpoModulesCore

struct RelativeLineStringDistance: Record {
  @Field
  var minimumHorizontalAccuracy: Double = 0.0
  
  @Field
  var automaticAdvanceDistance: Double?
}
