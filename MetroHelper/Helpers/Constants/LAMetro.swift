//
//  LAMetro.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/7/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation

struct LAMetro {
  let agency = "lametro-rail"
  
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
  }
  
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
  
  var allStops: [String] {
    return [
      Stop.museumStation.name,
      Stop.unionStation(.gold).name,
      Stop.seventhMetro(.gold).name,
      Stop.culverCity.name,
      Stop.palms.name
    ]
  }
}



