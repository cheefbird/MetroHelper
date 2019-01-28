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
  
  // MARK: - Properties
  let testLocation = CLLocationCoordinate2D(latitude: 34.0263909, longitude: -118.372572)
  
  let locationManager = CLLocationManager()
  
  // MARK: - Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    centerMap(onLocation: testLocation)
    
    let vehicleLocation = VehicleLocation(coordinate: testLocation, title: "Test Vehicle Location")
    mapView.addAnnotation(vehicleLocation)
    
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    checkLocationPermissionStatus()
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
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
    }
    
    return view
  }
}
