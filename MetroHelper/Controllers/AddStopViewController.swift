//
//  AddStopViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/31/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class AddStopViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var searchTextField: UITextField!
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  // MARK: - IBActions
  
  @IBAction func dismissSearchView() {
    self.dismiss(animated: true, completion: nil)
  }
  
}
