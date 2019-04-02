//
//  VehicleLocationViewController.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/24/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit
import MapKit

class VehicleLocationViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var refreshButton: UIBarButtonItem!
  @IBOutlet weak var overlayView: UIView!
  @IBOutlet weak var refreshSpinner: UIActivityIndicatorView!
  
  // MARK: - Properties
  let initialLocation = CLLocationCoordinate2D(latitude: 34.0263909, longitude: -118.372572)
  
  var trainId: Int!
  var vehicleLocation: VehicleLocation!
  let locationManager = CLLocationManager()
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.isRotateEnabled = false
    
    centerMap(onLocation: initialLocation)
    
    fetchVehicleLocation { success in
      if success {
        self.toggleRefreshOverlay()
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    checkLocationPermissionStatus()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showVehicleDetails" {
      let infoVC = segue.destination as! VehicleLocationInfoTableViewController
      infoVC.vehicleLocation = vehicleLocation
    }
  }
  
  // MARK: - Data Methods
  
  private func fetchVehicleLocation(_ completion: @escaping (Bool) -> Void) {
    
    MetroService.sharedInstance.getTrainLocation(forTrainId: trainId) { result in
      guard result.error == nil else {
        // TODO: Show error in alert modal
        debugPrint(result.error.debugDescription)
        return
      }
      
      if let newLocation = result.value {
        self.vehicleLocation = newLocation
        
        self.mapView.addAnnotation(newLocation)
        self.centerMap(onLocation: newLocation.coordinate)
        
        completion(true)
      } else {
        completion(false)
      }
    }
  }
  
  // MARK: - Methods
  
  private func centerMap(onLocation location: CLLocationCoordinate2D) {
    let testRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(testRegion, animated: true)
  }
  
  private func checkLocationPermissionStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      self.mapView.showsUserLocation = true
    } else {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  @IBAction func refreshView() {
    self.mapView.removeAnnotations(self.mapView.annotations)
    
    toggleRefreshOverlay()
    
    fetchVehicleLocation { success in
      if success {
        self.toggleRefreshOverlay()
      }
    }
  }
  
  private func toggleRefreshOverlay() {
    overlayView.isHidden = !overlayView.isHidden
    
    if refreshSpinner.isAnimating {
      refreshSpinner.stopAnimating()
    } else {
      refreshSpinner.startAnimating()
    }
    
  }
  
}

extension VehicleLocationViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
    guard let annotation = annotation as? VehicleLocation else { return nil }
    
    let identifier = "marker"
    var view: MKMarkerAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      view.animatesWhenAdded = true
      
      
    }
    
    return view
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
    performSegue(withIdentifier: "showVehicleDetails", sender: nil)
  }
}
