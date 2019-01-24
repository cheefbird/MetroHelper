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
  let allStops = LAMetro.allStops()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
  
  // MARK: - Methods
  
  // TODO: Pass StopID to PredictionTableVC for its fetch method
  
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    
    if segue.identifier == "showPredictions" {
      let nextVC = segue.destination as! PredictionTableViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        nextVC.stop = allStops[indexPath.row]
      }
    }
  }
  
  
}
