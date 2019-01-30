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
  var homePredictions = [Prediction]()
  var workPredictions = [Prediction]()
  
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
    return 2
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "Home"
    } else if section == 1 {
      return "Work"
    } else {
      return "Error"
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // 0 = HOME
    // 1 = WORK
    if section == 0 {
      return homePredictions.count
    } else if section == 1 {
      return workPredictions.count
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PredictionCell", for: indexPath) as! PredictionTableViewCell
    
    if indexPath.section == 0 {
      let prediction = homePredictions[indexPath.row]
      cell.configure(withPrediction: prediction)
    } else if indexPath.section == 1 {
      let prediction = workPredictions[indexPath.row]
      cell.configure(withPrediction: prediction)
    }
    
    return cell
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextVC = segue.destination as! VehicleLocationViewController
    if let indexPath = tableView.indexPathForSelectedRow {
      if indexPath.section == 0 {
        nextVC.trainId = homePredictions[indexPath.row].trainId
      } else {
        nextVC.trainId = workPredictions[indexPath.row].trainId
      }
    }
  }
  
  // MARK: - Data Methods
  
  @objc func fetchPredictions() {
    
    homePredictions.removeAll()
    workPredictions.removeAll()
    
    PredictionService.sharedInstance.getPredictions(forStop: stop.id) {
      result in
      
      guard result.error == nil else {
        // TODO: Show error in alert modal
        print(result.error.debugDescription)
        return
      }
      
      if let fetchedPredictions = result.value {
        for prediction in fetchedPredictions {
          if prediction.direction == "Home" {
            self.homePredictions.append(prediction)
          } else if prediction.direction == "Work" {
            self.workPredictions.append(prediction)
          } else {
            continue
          }
        }
      }
      
      self.tableView.reloadData()
      self.refreshControl?.endRefreshing()
    }
  }
  
}
