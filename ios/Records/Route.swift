import ExpoModulesCore

struct VisualInstructionContent: Record {
  @Field
  var text: String = ""
  
  @Field
  var maneuverType: String? // Enum mapping can be complex, using String for now or simple enum if possible
  
  @Field
  var maneuverModifier: String?
  
  @Field
  var roundaboutExitDegrees: Int?
  
  @Field
  var laneInfo: [LaneInfo]?
}

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

struct LaneInfo: Record {
  @Field
  var active: Bool = false
  
  @Field
  var directions: [String] = []
  
  @Field
  var activeDirection: String?
}

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

struct Route: Record {
  @Field
  var geometry: [GeographicCoordinate] = []
  
  @Field
  var bbox: BoundingBox = BoundingBox()
  
  @Field
  var distance: Double = 0.0
  
  @Field
  var waypoints: [Waypoint] = []
  
  @Field
  var steps: [RouteStep] = []
}
