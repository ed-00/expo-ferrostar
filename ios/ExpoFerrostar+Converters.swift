import ExpoModulesCore
import FerrostarCore
import CoreLocation

// Extensions to convert from Expo Records to Ferrostar SDK types

extension UserLocation {
  func toFerrostar() -> FerrostarCore.UserLocation {
    return FerrostarCore.UserLocation(
      coordinates: self.coordinates.toFerrostar(),
      horizontalAccuracy: self.horizontalAccuracy,
      courseOverGround: self.courseOverGround?.toFerrostar(),
      timestamp: ISO8601DateFormatter().date(from: self.timestamp) ?? Date(),
      speed: self.speed?.toFerrostar()
    )
  }
}

extension GeographicCoordinate {
  func toFerrostar() -> FerrostarCore.GeographicCoordinate {
    return FerrostarCore.GeographicCoordinate(lat: self.lat, lng: self.lng)
  }
}

extension Waypoint {
  func toFerrostar() -> FerrostarCore.Waypoint {
    return FerrostarCore.Waypoint(
      coordinate: self.coordinate.toFerrostar(),
      kind: FerrostarCore.WaypointKind(rawValue: self.kind.rawValue) ?? .break
    )
  }
}

extension CourseOverGround {
  func toFerrostar() -> FerrostarCore.CourseOverGround {
    return FerrostarCore.CourseOverGround(
      degrees: UInt16(self.degrees), // Assuming type
      accuracy: self.accuracy.map { UInt16($0) }
    )
  }
}

extension Speed {
  func toFerrostar() -> FerrostarCore.Speed {
    return FerrostarCore.Speed(
      value: self.value,
      accuracy: self.accuracy
    )
  }
}

// Forward Converters (Record -> SDK)

extension Route {
  func toFerrostar() -> FerrostarCore.Route {
    return FerrostarCore.Route(
      geometry: self.geometry.map { $0.toFerrostar() },
      bbox: self.bbox.toFerrostar(),
      distance: self.distance,
      waypoints: self.waypoints.map { $0.toFerrostar() },
      steps: self.steps.map { $0.toFerrostar() }
    )
  }
}

extension BoundingBox {
  func toFerrostar() -> FerrostarCore.BoundingBox {
    return FerrostarCore.BoundingBox(
      ne: self.ne.toFerrostar(),
      sw: self.sw.toFerrostar()
    )
  }
}

extension RouteStep {
  func toFerrostar() -> FerrostarCore.RouteStep {
    return FerrostarCore.RouteStep(
      geometry: self.geometry.map { $0.toFerrostar() },
      distance: self.distance,
      duration: self.duration,
      roadName: self.roadName,
      instruction: self.instruction,
      visualInstructions: self.visualInstructions.map { $0.toFerrostar() },
      spokenInstructions: self.spokenInstructions.map { $0.toFerrostar() },
      annotations: self.annotations
    )
  }
}

extension VisualInstruction {
  func toFerrostar() -> FerrostarCore.VisualInstruction {
    return FerrostarCore.VisualInstruction(
      primaryContent: self.primaryContent.toFerrostar(),
      secondaryContent: self.secondaryContent?.toFerrostar(),
      subContent: self.subContent?.toFerrostar(),
      triggerDistanceBeforeManeuver: self.triggerDistanceBeforeManeuver
    )
  }
}

extension VisualInstructionContent {
  func toFerrostar() -> FerrostarCore.VisualInstructionContent {
    return FerrostarCore.VisualInstructionContent(
      text: self.text,
      maneuverType: self.maneuverType.flatMap { FerrostarCore.ManeuverType(rawValue: $0) }, // Assuming String -> Enum
      maneuverModifier: self.maneuverModifier.flatMap { FerrostarCore.ManeuverModifier(rawValue: $0) },
      roundaboutExitDegrees: self.roundaboutExitDegrees.map { UInt16($0) },
      laneInfo: self.laneInfo?.map { $0.toFerrostar() }
    )
  }
}

extension LaneInfo {
  func toFerrostar() -> FerrostarCore.LaneInfo {
    return FerrostarCore.LaneInfo(
      active: self.active,
      directions: self.directions.flatMap { FerrostarCore.LaneDirection(rawValue: $0) }, // Assuming String -> Enum
      activeDirection: self.activeDirection.flatMap { FerrostarCore.LaneDirection(rawValue: $0) }
    )
  }
}

extension SpokenInstruction {
  func toFerrostar() -> FerrostarCore.SpokenInstruction {
    return FerrostarCore.SpokenInstruction(
      text: self.text,
      ssml: self.ssml,
      triggerDistanceBeforeManeuver: self.triggerDistanceBeforeManeuver,
      utteranceId: self.utteranceId
    )
  }
}

extension FerrostarCore.Route {
  func toRecord() -> Route {
    return Route(
      geometry: self.geometry.map { $0.toRecord() },
      bbox: self.bbox.toRecord(),
      distance: self.distance,
      waypoints: self.waypoints.map { $0.toRecord() },
      steps: self.steps.map { $0.toRecord() }
    )
  }
}

extension FerrostarCore.GeographicCoordinate {
  func toRecord() -> GeographicCoordinate {
    return GeographicCoordinate(lat: self.lat, lng: self.lng)
  }
}

extension FerrostarCore.BoundingBox {
  func toRecord() -> BoundingBox {
    return BoundingBox(
      ne: self.ne.toRecord(),
      sw: self.sw.toRecord()
    )
  }
}

extension FerrostarCore.Waypoint {
  func toRecord() -> Waypoint {
    return Waypoint(
      coordinate: self.coordinate.toRecord(),
      kind: WaypointKind(rawValue: self.kind.rawValue) ?? .break_
    )
  }
}

extension FerrostarCore.RouteStep {
  func toRecord() -> RouteStep {
    return RouteStep(
      geometry: self.geometry.map { $0.toRecord() },
      distance: self.distance,
      duration: self.duration,
      roadName: self.roadName,
      instruction: self.instruction,
      visualInstructions: self.visualInstructions.map { $0.toRecord() },
      spokenInstructions: self.spokenInstructions.map { $0.toRecord() },
      annotations: self.annotations ?? []
    )
  }
}

extension FerrostarCore.VisualInstruction {
  func toRecord() -> VisualInstruction {
    return VisualInstruction(
      primaryContent: self.primaryContent.toRecord(),
      secondaryContent: self.secondaryContent?.toRecord(),
      subContent: self.subContent?.toRecord(),
      triggerDistanceBeforeManeuver: self.triggerDistanceBeforeManeuver
    )
  }
}

extension FerrostarCore.VisualInstructionContent {
  func toRecord() -> VisualInstructionContent {
    return VisualInstructionContent(
      text: self.text,
      maneuverType: self.maneuverType?.name, // Assuming Enum name access
      maneuverModifier: self.maneuverModifier?.name,
      roundaboutExitDegrees: self.roundaboutExitDegrees.map { Int($0) },
      laneInfo: self.laneInfo?.map { $0.toRecord() }
    )
  }
}

extension FerrostarCore.LaneInfo {
  func toRecord() -> LaneInfo {
    return LaneInfo(
      active: self.active,
      directions: self.directions.map { $0.name }, // Assuming Enum
      activeDirection: self.activeDirection?.name
    )
  }
}

extension FerrostarCore.SpokenInstruction {
  func toRecord() -> SpokenInstruction {
    return SpokenInstruction(
      text: self.text,
      ssml: self.ssml,
      triggerDistanceBeforeManeuver: self.triggerDistanceBeforeManeuver,
      utteranceId: self.utteranceId
    )
  }
}
