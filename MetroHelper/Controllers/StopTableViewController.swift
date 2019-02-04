//
//  StopTableViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/3/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class StopTableViewController: UITableViewController {
  
  // MARK: - Properties
  let allStopNames = LAMetro.allStopNames
  var allStops = LAMetro.allStops()
  
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
    return allStops.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let stop = allStops[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath)
    
    cell.textLabel?.text = stop.displayName
    
    return cell
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    
    if segue.identifier == "showPredictions" {
      let nextVC = segue.destination as! PredictionTableViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        nextVC.stop = allStops[indexPath.row]
      }
    } else if segue.identifier == "presentAddStop" {
      let nextVC = segue.destination as! AddStopViewController
      nextVC.delegate = self
    }
  }
}

// MARK: - Stop Modifier Delegate

extension StopTableViewController: StopModifierDelegate {
  
  func addStop(_ stop: Stop) {
    allStops.append(stop)
    
    self.tableView.reloadData()
  }
}
