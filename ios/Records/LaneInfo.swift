import ExpoModulesCore

struct LaneInfo: Record {
  @Field
  var active: Bool = false
  
  @Field
  var directions: [String] = []
  
  @Field
  var activeDirection: String?
}
