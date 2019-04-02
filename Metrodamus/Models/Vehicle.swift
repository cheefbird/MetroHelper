//
//  Vehicle.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/28/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import SwiftyJSON
import MapKit

struct Vehicle {
  
  // MARK: - Properties
  
  let id: Int
  var latitude: Float
  var longitude: Float
  let routeId: Int
  var secondsSinceReport: Int
  let runId: String
  
  // MARK: Initializers
  
  init(id: Int, latitude: Float, longitude: Float, routeId: Int, secondsSinceReport: Int, runId: String) {
    self.id = id
    self.latitude = latitude
    self.longitude = longitude
    self.routeId = routeId
    self.secondsSinceReport = secondsSinceReport
    self.runId = runId
  }
  
  init?(withJson json: JSON, forTrainID trainId: Int) {
    if json["id"].intValue != trainId {
      return nil
    }
    id = trainId
    latitude = json["latitude"].floatValue
    longitude = json["longitude"].floatValue
    routeId = json["route_id"].intValue
    secondsSinceReport = json["seconds_since_report"].intValue
    runId = json["run_id"].stringValue
  }
  
  // MARK: - Methods
  
  func getCoordinate() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: CLLocationDegrees(self.latitude), longitude: CLLocationDegrees(self.longitude))
  }
}



