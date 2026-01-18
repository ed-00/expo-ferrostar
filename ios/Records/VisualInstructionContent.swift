import ExpoModulesCore

struct VisualInstructionContent: Record {
  @Field
  var text: String = ""
  
  @Field
  var maneuverType: String?
  
  @Field
  var maneuverModifier: String?
  
  @Field
  var roundaboutExitDegrees: Int?
  
  @Field
  var laneInfo: [LaneInfo]?
}
