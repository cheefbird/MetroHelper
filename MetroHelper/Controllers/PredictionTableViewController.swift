//
//  PredictionTableViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class PredictionTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  var stop: Stop!
  var predictions = [Prediction]()
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = stop.displayName
    
    print(stop.id)
    
    fetchPredictions()
    
    self.refreshControl?.addTarget(self, action: #selector(fetchPredictions), for: .valueChanged)
  }
  
  // MARK: - Data Source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return predictions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PredictionCell", for: indexPath) as! PredictionTableViewCell
    
    let prediction = predictions[indexPath.row]
    
    cell.configure(withPrediction: prediction)
    
    return cell
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextVC = segue.destination as! VehicleLocationViewController
    if let indexPath = tableView.indexPathForSelectedRow {
      nextVC.trainId = predictions[indexPath.row].trainId
    }
  }
  
  // MARK: - Data Methods
  
  @objc func fetchPredictions() {
    
    PredictionService.sharedInstance.getPredictions(forStop: stop.id) {
      result in
      
      guard result.error == nil else {
        // TODO: Show error in alert modal
        print(result.error.debugDescription)
        return
      }
      
      if let fetchedPredictions = result.value {
        self.predictions = fetchedPredictions
        print("PREDICTIONS:")
        print(fetchedPredictions)
      }
      
      self.tableView.reloadData()
      self.refreshControl?.endRefreshing()
    }
  }
  
}
