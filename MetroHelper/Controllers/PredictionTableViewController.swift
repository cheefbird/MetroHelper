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
  
  let predictions = PredictionData().sampleData
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
