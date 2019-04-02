//
//  VehicleLocationInfoTableViewController.swift
//  Metrodamus
//
//  Created by Francis Breidenbach on 4/1/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class VehicleLocationInfoTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  var vehicleLocation: VehicleLocation!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleLocationPropertyCell")!
    
    cell.textLabel?.text = "VERIFY"
    cell.detailTextLabel?.text = "\(vehicleLocation.vehicle.id)"
    
    return cell
  }
}
