import ExpoModulesCore

enum ManeuverType: String, Enumerable {
  case turn
  case new_name
  case depart
  case arrive
  case merge
  case on_ramp
  case off_ramp
  case fork
  case end_of_road
  case continue_ = "continue"
  case roundabout
  case notification
  case exit_roundabout
  case exit_rotary
}
