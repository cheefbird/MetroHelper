//
//  Stop.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Stop {
  let latitude: Float?
  let longitude: Float?
  var displayName: String
  var id: Int
  let line: TrainLine?
  
  init(forLine line: TrainLine, fromJSON json: JSON) {
    self.latitude = json["latitude"].floatValue
    self.longitude = json["longitude"].floatValue
    self.displayName = json["display_name"].stringValue
    self.id = json["id"].intValue
    self.line = line
  }
  
  init(displayName: String, id: Int) {
    self.displayName = displayName
    self.id = id
    self.latitude = nil
    self.longitude = nil
    self.line = nil
  }
  
  init(displayName: String, id: Int, line: TrainLine) {
    self.displayName = displayName
    self.id = id
    self.line = line
    self.latitude = nil
    self.longitude = nil
  }
}
