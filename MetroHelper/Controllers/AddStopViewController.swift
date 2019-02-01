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
  
  
  
  // MARK: - Outlets
  
  @IBOutlet weak var lineSelectField: DropDown!
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    lineSelectField.optionArray = ["804", "806", "801"]
  }
  
  // MARK: - IBActions
  
  @IBAction func dismissSearchView() {
    self.dismiss(animated: true, completion: nil)
  }
  
}
