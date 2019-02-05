//
//  StopTableViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/3/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit
import RealmSwift

class StopTableViewController: UITableViewController {
  
  // MARK: - Properties
  var allStops = LAMetro.allStops()
  var stops: Results<RealmStop>!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    let realm = try! Realm()
    
    stops = realm.objects(RealmStop.self)
    
    setTableEditable()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return stops.count > 0 ? stops.count : 1
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath)
    
    guard stops.count > 0 else {
      cell.textLabel?.text = "Add Stops to Continue!"
      return cell
    }
    
    let stop = stops[indexPath.row]
    
    cell.textLabel?.text = stop.displayName
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    guard stops.count > 0 else { return }
    
    let realm = try! Realm()
    
    let stop = stops[indexPath.row]
    
    if editingStyle == .delete {
      try! realm.write {
        realm.delete(stop)
      }
      setTableEditable()
      self.tableView.reloadData()
      //      self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    guard stops.count > 0 else { return false }
    
    return true
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
    
    if segue.identifier == "showPredictions" {
      let nextVC = segue.destination as! PredictionTableViewController
      if let indexPath = tableView.indexPathForSelectedRow {
        nextVC.stop = stops[indexPath.row]
      }
    } else if segue.identifier == "presentAddStop" {
      let nextVC = segue.destination as! AddStopViewController
      nextVC.delegate = self
    }
  }
  
  // MARK: - Methods
  
  private func setTableEditable() {
    print("SET TABLE EDITABLE DEBUG:")
    print(stops.count)
    if stops.count < 1 {
      tableView.allowsSelection = false
    }
  }
}

// MARK: - Stop Modifier Delegate

extension StopTableViewController: StopModifierDelegate {
  
  func addStop(_ stop: StopObject) {
    let realm = try! Realm()
    
    let newRealmStop = RealmStop(fromStop: stop)
    try! realm.write {
      realm.add(newRealmStop)
    }
    
    self.tableView.allowsSelection = true
    self.tableView.reloadData()
  }
}
