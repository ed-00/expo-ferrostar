import ExpoModulesCore

struct RouteStep: Record {
  @Field
  var geometry: [GeographicCoordinate] = []
  
  @Field
  var distance: Double = 0.0
  
  @Field
  var duration: Double = 0.0
  
  @Field
  var roadName: String?
  
  @Field
  var instruction: String = ""
  
  @Field
  var visualInstructions: [VisualInstruction] = []
  
  @Field
  var spokenInstructions: [SpokenInstruction] = []
  
  @Field
  var annotation: [String] = []
}
