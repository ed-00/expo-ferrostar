import ExpoModulesCore
// import Ferrostar // Assumed available via SPM

public class ExpoFerrostarModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoFerrostar")

    View(ExpoFerrostarView.self) {
      Events("onNavigationStateChange")

      Prop("navigationOptions") { (view: ExpoFerrostarView, options: FerrostarNavigationOptions) in
        view.setNavigationOptions(options)
      }

      Prop("coreOptions") { (view: ExpoFerrostarView, options: FerrostarCoreOptions) in
        view.setCoreOptions(options)
      }

      AsyncFunction("getRoutes") { (view: ExpoFerrostarView, initialLocation: UserLocation, waypoints: [Waypoint]) in
        return await view.getRoutes(initialLocation, waypoints)
      }

      AsyncFunction("startNavigation") { (view: ExpoFerrostarView, route: Route, options: NavigationControllerConfig?) in
        view.startNavigation(route, options)
      }

      AsyncFunction("stopNavigation") { (view: ExpoFerrostarView, stopLocationUpdates: Bool?) in
        view.stopNavigation(stopLocationUpdates)
      }

      AsyncFunction("replaceRoute") { (view: ExpoFerrostarView, route: Route, options: NavigationControllerConfig?) in
        view.replaceRoute(route, options)
      }

      AsyncFunction("advanceToNextStep") { (view: ExpoFerrostarView) in
        view.advanceToNextStep()
      }
    }
  }
}
