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
  let agency = "lametro-rail"
  
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
  
  enum Stop {
    
    case museumStation
    case unionStation(Line)
    case seventhMetro(Line)
    case culverCity
    case palms
    
    var name: String {
      switch self {
      case .museumStation:
        return "Museum Station"
        
      case .unionStation:
        return "Union Station"
        
      case .seventhMetro:
        return "7th Street/Metro Center"
        
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
  static var allStops: [String] {
    return [
      Stop.museumStation.name,
      Stop.unionStation(.gold).name,
      Stop.seventhMetro(.gold).name,
      Stop.culverCity.name,
      Stop.palms.name
    ]
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
}
