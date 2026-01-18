import ExpoModulesCore

struct NavigationControllerConfig: Record {
  @Field
  var stepAdvance: RelativeLineStringDistance = RelativeLineStringDistance()
  
  @Field
  var routeDeviationTracking: StaticThreshold = StaticThreshold()
  
  @Field
  var courseFiltering: CourseFiltering = .SNAP_TO_ROUTE
}
