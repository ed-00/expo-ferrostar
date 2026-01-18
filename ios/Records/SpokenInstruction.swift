import ExpoModulesCore

struct SpokenInstruction: Record {
  @Field
  var text: String = ""
  
  @Field
  var ssml: String?
  
  @Field
  var triggerDistanceBeforeManeuver: Double = 0.0
  
  @Field
  var utteranceId: String = ""
}
