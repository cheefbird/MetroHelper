//
//  StopModifierDelegate.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 2/4/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation

protocol StopModifierDelegate: AnyObject  {
  
  // MARK: - Methods
  
  /// Add a Stop object to the receiver's **allStops** array.
  ///
  /// - Parameter stop: Stop object to be added to receiver's array.
  func addStop(_ stop: Stop)
}
