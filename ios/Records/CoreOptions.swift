import ExpoModulesCore

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
