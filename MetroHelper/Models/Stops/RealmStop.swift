//
//  RealmStop.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 2/4/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import RealmSwift

class RealmStop: Object, StopObject {
  
  // MARK: - Properties
  
  @objc dynamic var latitude: Float = 0
  @objc dynamic var longitude: Float = 0
  @objc dynamic var displayName = ""
  @objc dynamic var id = 0
  
  // MARK: - Init
  
  convenience required init(fromStop stop: StopObject) {
    self.init()
    
    latitude = stop.latitude
    longitude = stop.longitude
    displayName = stop.displayName
    id = stop.id
  }
  
  // MARK: - Overrides
  
  override static func primaryKey() -> String? {
    return "id"
  }
}
