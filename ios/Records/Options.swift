import ExpoModulesCore

enum LocationMode: String, Enumerable {
  case fused
  case default_ = "default"
  case simulated
}

struct RelativeLineStringDistance: Record {
  @Field
  var minimumHorizontalAccuracy: Double = 0.0
  
  @Field
  var automaticAdvanceDistance: Double?
}

struct StaticThreshold: Record {
  @Field
  var minimumHorizontalAccuracy: Double = 0.0
  
  @Field
  var maxAcceptableDeviation: Double = 0.0
}

enum CourseFiltering: String, Enumerable {
  case SNAP_TO_ROUTE
  case RAW
}

struct NavigationControllerConfig: Record {
  @Field
  var stepAdvance: RelativeLineStringDistance = RelativeLineStringDistance() // TODO: check if this matches
  
  @Field
  var routeDeviationTracking: StaticThreshold = StaticThreshold()
  
  @Field
  var courseFiltering: CourseFiltering = .SNAP_TO_ROUTE
}

struct FerrostarCoreOptions: Record {
  @Field
  var locationMode: LocationMode = .default_
  
  @Field
  var valhallaEndpointURL: String?
  
  @Field
  var profile: String?
  
  @Field
  var options: [String: Any]?
  
  @Field
  var navigationControllerConfig: NavigationControllerConfig?
}

struct FerrostarNavigationOptions: Record {
  @Field
  var styleUrl: String?
  
  @Field
  var snapUserLocationToRoute: Bool?
}
