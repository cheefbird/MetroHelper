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
  var availableStops = [StopObject]()
  var selectedLine: TrainLine?
  weak var delegate: StopModifierDelegate!
  
  // MARK: - Outlets
  
  @IBOutlet weak var lineSelectField: DropDown!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var lineNames = [String]()
    
    for line in allLines {
      lineNames.append(line.displayName)
    }
    
    lineSelectField.optionArray = lineNames
    
    lineSelectField.didSelect { (selectedText, index, id) in
      self.loadingSpinner.startAnimating()
      
      let selectedLine = self.allLines[index]
      self.selectedLine = selectedLine
      
      self.fetchStops(forTrainLine: selectedLine)
    }
  }
  
  // MARK: - IBActions
  
  @IBAction func dismissSearchView() {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Data Methods
  
  private func fetchStops(forTrainLine line: TrainLine) {
    MetroService.sharedInstance.getStops(forLine: line) { result in
      
      guard result.error == nil else {
        // TODO: Show error in alert modal
        debugPrint(result.error.debugDescription)
        return
      }
      
      if let stops = result.value {
        self.availableStops = stops.sorted(by: {$0.displayName < $1.displayName })
      }
      
      self.loadingSpinner.stopAnimating()
      self.tableView.reloadData()
    }
  }
}

// MARK: - Table View Data Source

extension AddStopViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if availableStops.count < 1 {
      return 0
    } else {
      return availableStops.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddStopCell", for: indexPath) as! AddStopTableViewCell
    
    let stop = availableStops[indexPath.row]
    guard let line = selectedLine?.displayName else { return cell }
    
    cell.configure(forStopNamed: stop.displayName, withLineNamed: line)
    
    return cell
  }
}

// MARK: - Table View Delegate

extension AddStopViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let stopToAdd = availableStops[indexPath.row]
    
//    delegate.addStop(stopToAdd)
    
    self.dismiss(animated: true) { [weak self] in
      self?.delegate.addStop(stopToAdd)
    }
  }
}
