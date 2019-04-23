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
  let trainId: Int
  let direction: String
  var age: Int
  
  init(seconds: Int, minutes: Int, routeId: Int, runId: String, trainId: Int) {
    self.seconds = seconds
    self.minutes = minutes
    self.routeId = routeId
    self.runId = runId
    self.trainId = trainId
    self.direction = LAMetro.getDirection(forRunID: runId)
    self.age = 0
  }
  
  init?(json: JSON) {
    
    if json["route_id"].intValue < 1 {
      return nil
    }
    
    self.seconds = json["seconds"].intValue
    self.minutes = json["minutes"].intValue
    self.routeId = json["route_id"].intValue
    self.runId = json["run_id"].stringValue
    self.trainId = json["block_id"].intValue
    self.direction = LAMetro.getDirection(forRunID: self.runId)
    self.age = 0
  }
}
