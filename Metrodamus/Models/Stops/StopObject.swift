//
//  StopObject.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 2/4/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation

protocol StopObject: AnyObject {
  var latitude: Float { get }
  var longitude: Float { get }
  var displayName: String { get }
  var id: Int { get }
}
