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
  var availableStops = [Stop]()
  
  // MARK: - Outlets
  
  @IBOutlet weak var lineSelectField: DropDown!
  @IBOutlet weak var tableView: UITableView!
  
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


// MARK: - Table View Data Source

extension AddStopViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "AddStopCell")
    
    return cell
  }
  
  
}
