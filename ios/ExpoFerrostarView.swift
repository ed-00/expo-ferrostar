import ExpoModulesCore
import SwiftUI
import FerrostarCore
import FerrostarMapLibreUI 

class ExpoFerrostarView: ExpoView {
  private let onNavigationStateChange = EventDispatcher()
  
  private var core: FerrostarCore?
  private var ferrostarView: FerrostarView? // SwiftUI view wrapper?
  private var hostingController: UIHostingController<AnyView>?

  private var coreOptions: FerrostarCoreOptions?
  private var navigationOptions: FerrostarNavigationOptions?

  required init(appContext: AppContext? = nil) {
    super.init(appContext: appContext)
    clipsToBounds = true
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    hostingController?.view.frame = bounds
  }

  func setNavigationOptions(_ options: FerrostarNavigationOptions) {
    self.navigationOptions = options
    updateView()
  }

  func setCoreOptions(_ options: FerrostarCoreOptions) {
    self.coreOptions = options
    updateCore()
  }
  
  private func updateCore() {
    guard let options = coreOptions else { return }

    // Location Provider
    let locationProvider: LocationProvider
    if options.locationMode == .simulated {
      locationProvider = SimulatedLocationProvider()
    } else {
      // Default to CoreLocation
      // TODO: Handle 'fused' vs 'default' if distinct, or configure CoreLocation options
      locationProvider = CoreLocationProvider(activityType: .automotiveNavigation, allowBackgroundLocationUpdates: true) 
    }

    // Initialize Core
    // TODO: Map navigationControllerConfig
    do {
      self.core = try FerrostarCore(
        valhallaEndpointUrl: URL(string: options.valhallaEndpointURL ?? "https://api.stadiamaps.com/route/v1")!, // Fallback or force unwrapping?
        profile: options.profile ?? "bicycle",
        locationProvider: locationProvider,
        navigationControllerConfig: mapCoreConfig(options.navigationControllerConfig)
      )
      
      updateView()
    } catch {
      print("Error initializing FerrostarCore: \(error)")
    }
  }
  
  private func updateView() {
    guard let core = core else { return }
    
    // Create UI
    // Ensure we are on main thread
    DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }

        // Initialize FerrostarView with configuration
        // TODO: Pass actual theme/map style from navigationOptions if available
        let view: FerrostarView
        if let styleUrl = self.navigationOptions?.styleUrl, let url = URL(string: styleUrl) {
            // Using a custom MapLibre style
            // Note: FerrostarMapLibreUI init signature might vary. Assuming basic init(core:styleURL:)
            // If strictly using default style:
             view = FerrostarView(core: core) 
             // If styleUrl support is needed, we need to check FerrostarView initializer options
        } else {
             view = FerrostarView(core: core)
        }
        
        if self.hostingController == nil {
          self.hostingController = UIHostingController(rootView: AnyView(view))
          if let hostView = self.hostingController?.view {
            hostView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(hostView)
            NSLayoutConstraint.activate([
              hostView.topAnchor.constraint(equalTo: self.topAnchor),
              hostView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
              hostView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              hostView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
          }
        } else {
          self.hostingController?.rootView = AnyView(view)
        }
    }
  }

  func getRoutes(_ initialLocation: UserLocation, _ waypoints: [Waypoint]) async -> [Route] {
    guard let core = core else {
      print("FerrostarCore not initialized")
      return []
    }
    
    do {
      let routes = try await core.getRoutes(
        initialLocation: initialLocation.toFerrostar(),
        waypoints: waypoints.map { $0.toFerrostar() }
      )
      return routes.map { $0.toRecord() }
    } catch {
      print("Error getting routes: \(error)")
      return []
    }
  }

  func startNavigation(_ route: Route, _ options: NavigationControllerConfig?) {
    guard let core = core else { return }

    // Map config
    let config: FerrostarCore.NavigationControllerConfig?
    if let options = options {
       config = FerrostarCore.NavigationControllerConfig(
          stepAdvance: FerrostarCore.RelativeLineStringDistance(
            minimumHorizontalAccuracy: options.stepAdvance.minimumHorizontalAccuracy,
            automaticAdvanceDistance: options.stepAdvance.automaticAdvanceDistance
          ),
          routeDeviationTracking: FerrostarCore.StaticThreshold(
            minimumHorizontalAccuracy: options.routeDeviationTracking.minimumHorizontalAccuracy,
            maxAcceptableDeviation: options.routeDeviationTracking.maxAcceptableDeviation
          ),
          courseFiltering: .snapToRoute // TODO: Map enum
       )
    } else {
       config = nil
    }

    try? core.startNavigation(route: route.toFerrostar(), config: config)
  }
  
  // Helper to map config from CoreOptions too
  private func mapCoreConfig(_ config: NavigationControllerConfig?) -> FerrostarCore.NavigationControllerConfig {
      guard let config = config else {
          // Return default
          return FerrostarCore.NavigationControllerConfig(
            stepAdvance: FerrostarCore.RelativeLineStringDistance(minimumHorizontalAccuracy: 20, automaticAdvanceDistance: nil),
            routeDeviationTracking: FerrostarCore.StaticThreshold(minimumHorizontalAccuracy: 20, maxAcceptableDeviation: 20),
            courseFiltering: .snapToRoute
          )
      }
      return FerrostarCore.NavigationControllerConfig(
          stepAdvance: FerrostarCore.RelativeLineStringDistance(
            minimumHorizontalAccuracy: config.stepAdvance.minimumHorizontalAccuracy,
            automaticAdvanceDistance: config.stepAdvance.automaticAdvanceDistance
          ),
          routeDeviationTracking: FerrostarCore.StaticThreshold(
            minimumHorizontalAccuracy: config.routeDeviationTracking.minimumHorizontalAccuracy,
            maxAcceptableDeviation: config.routeDeviationTracking.maxAcceptableDeviation
          ),
          courseFiltering: .snapToRoute
      )
  }

  func stopNavigation(_ stopLocationUpdates: Bool?) {
     core?.stopNavigation() // TODO: Handle stopLocationUpdates arg if supported
  }

  func replaceRoute(_ route: Route, _ options: NavigationControllerConfig?) {
     // TODO: Implement replaceRoute logic with config mapping similar to startNavigation
     guard let core = core else { return }
     let config = mapCoreConfig(options)
     try? core.replaceRoute(route: route.toFerrostar(), config: config)
  }
  
  func advanceToNextStep() {
     try? core?.advanceToNextStep()
  }
}
