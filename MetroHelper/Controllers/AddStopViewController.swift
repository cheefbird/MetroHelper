//
//  AddStopViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/31/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit
import iOSDropDown

class AddStopViewController: UIViewController {
  
  // MARK: - Properties
  
  let allLines = LAMetro.getAllLines()
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var lineSelectField: DropDown!
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var lineNames = [String]()
    
    for line in allLines {
      lineNames.append(line.displayName)
    }
    
    lineSelectField.optionArray = lineNames
  }
  
  // MARK: - IBActions
  
  @IBAction func dismissSearchView() {
    self.dismiss(animated: true, completion: nil)
  }
  
}
