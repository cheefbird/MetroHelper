//
//  Prediction.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Prediction {
  var seconds: Int
  var minutes: Int
  let routeId: Int
  let runId: String
  
  init(seconds: Int, minutes: Int, routeId: Int, runId: String) {
    self.seconds = seconds
    self.minutes = minutes
    self.routeId = routeId
    self.runId = runId
  }
  
  init?(json: JSON) {
    guard let routeId = json["route_id"].int else {
      return nil
    }
    
    self.seconds = json["seconds"].intValue
    self.minutes = json["minutes"].intValue
    self.routeId = routeId
    self.runId = json["run_id"].stringValue
  }
}
