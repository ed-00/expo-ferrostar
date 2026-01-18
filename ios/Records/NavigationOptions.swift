import ExpoModulesCore

struct FerrostarNavigationOptions: Record {
  @Field
  var styleUrl: String?
  
  @Field
  var snapUserLocationRoute: Bool?
}
