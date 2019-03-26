//
//  UIView+Designable.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 2/3/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {}

extension CustomView {
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      } else {
        return .black
      }
    }
    set {
      layer.borderColor = newValue.cgColor
    }
  }
}
