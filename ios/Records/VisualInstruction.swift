import ExpoModulesCore

struct VisualInstruction: Record {
  @Field
  var primaryContent: VisualInstructionContent = VisualInstructionContent()
  
  @Field
  var secondaryContent: VisualInstructionContent?
  
  @Field
  var subContent: VisualInstructionContent?
  
  @Field
  var triggerDistanceBeforeManeuver: Double = 0.0
}
