//
//  LAMetro.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/7/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation

/// Object containing all relevant Stop and Line data properties.

struct LAMetro {
  
  // MARK: - Properties
  
  /// Agency constant. Always "lametro-rail".
  static let agency = "lametro-rail"
  
  // MARK: - Line
  
  enum Line {
    
    case redPurple
    case expo
    case gold
    
    var id: Int {
      switch self {
      case .redPurple:
        return 802
        
      case .expo:
        return 806
        
      case .gold:
        return 804
      }
    }
    
    var workDirectionId: String {
      switch self {
      case .redPurple:
        return "802_1_var0"
        
      case .expo:
        return "806_1_var1"
        
      case .gold:
        return "804_1_var0"
      }
    }
    
    var homeDirectionId: String {
      switch self {
      case .redPurple:
        return "802_0_var0"
        
      case .expo:
        return "806_0_var0"
        
      case .gold:
        return "804_0_var0"
      }
    }
  }
  
  // MARK: - Stop
  
  enum Station {
    
    case museumStation
    case unionStation(Line)
    case seventhMetro(Line)
    case culverCity
    case palms
    
    var name: String {
      switch self {
      case .museumStation:
        return "Museum Station"
        
      case .unionStation(let line):
        switch line {
        case .gold:
          return "Union Station: Gold"
          
        case .redPurple:
          return "Union Station: Red/Purple"
          
        default:
          return "None"
        }
        
      case .seventhMetro(let line):
        switch line {
        case .redPurple:
          return "7th/Metro Center: Red/Purple"
          
        case .expo:
          return "7th/Metro Center: Expo"
          
        default:
          return "None"
        }
        
      case .culverCity:
        return "Culver City"
        
      case .palms:
        return "Palms"
      }
    }
    
    var id: Int {
      switch self {
      case .museumStation:
        return 80413
        
      case .unionStation(let line):
        let stationId: Int
        switch line {
        case .redPurple:
          stationId = 80214
          
        case .gold:
          stationId = 80409
          
        default:
          stationId = 1
        }
        return stationId
        
      case .seventhMetro(let line):
        let stationId: Int
        switch line {
        case .redPurple:
          stationId = 80211
          
        case .expo:
          stationId = 80122
          
        default:
          stationId = 1
        }
        return stationId
        
      case .culverCity:
        return 80132
        
      case .palms:
        return 80133
      }
    }
  }
  
  // MARK: - Helpers
  
  /// Returns an array of Strings containing displayName of all Stops.
  static var allStopNames: [String] {
    return [
      Station.museumStation.name,
      Station.unionStation(.gold).name,
      Station.seventhMetro(.gold).name,
      Station.culverCity.name,
      Station.palms.name
    ]
  }
  
  static func allStops() -> [Stop] {
    var stops = [Stop]()
    
    // Museum station stop
    stops.append(Stop(displayName: Station.museumStation.name, id: Station.museumStation.id))
    
    // Union station stops
    stops.append(Stop(displayName: Station.unionStation(.gold).name, id: Station.unionStation(.gold).id))
    stops.append(Stop(displayName: Station.unionStation(.redPurple).name, id: Station.unionStation(.redPurple).id))
    
    // 7th/Metro station stops
    stops.append(Stop(displayName: Station.seventhMetro(.redPurple).name, id: Station.seventhMetro(.redPurple).id))
    stops.append(Stop(displayName: Station.seventhMetro(.expo).name, id: Station.seventhMetro(.expo).id))
    
    // Culver city station stops
    stops.append(Stop(displayName: Station.culverCity.name, id: Station.culverCity.id))
    
    // Palms station stops
    stops.append(Stop(displayName: Station.palms.name, id: Station.palms.id))
    
    print(stops)
    
    return stops
    
  }
  
  /// Helper method that converts runId String to relevant direction of "Home" or "Work".
  ///
  /// - Parameter runId: Prediction runId property
  /// - Returns: Human readable direction; **Home** or **Work**.
  /// - Note: Returns **None** when runId is invalid.
  static func getDirection(from runId: String) -> String {
    switch runId {
    case "802_1_var0", "806_1_var1", "804_1_var0":
      return "Work"
      
    case "802_0_var0", "806_0_var0", "804_0_var0":
      return "Home"
      
    default:
      return "None"
    }
  }
  
  static func getStopIds(forStation station: String) -> [Int] {
    
    var results = [Int]()
    
    switch station {
    case "Museum Station":
      results.append(Station.museumStation.id)
      return results
      
    case "7th Street/Metro Center":
      results.append(Station.seventhMetro(.redPurple).id)
      results.append(Station.seventhMetro(.expo).id)
      return results
      
    case "Culver City":
      results.append(Station.culverCity.id)
      return results
      
    case "Union Station":
      results.append(Station.unionStation(.gold).id)
      results.append(Station.unionStation(.redPurple).id)
      return results
      
    case "Palms":
      results.append(Station.palms.id)
      return results
      
    default:
      return results
    }
  }
}


