//
//  PredictionService.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MetroService {
  
  // MARK: - Properties
  
  static let sharedInstance = MetroService()
  
  // MARK: - Init
  
  private init() {}
  
  
  // MARK: - GET Predictions
  
  /// Retrieve Predictions for a given Stop ID.
  ///
  /// - Parameters:
  ///   - stopId: ID of the Stop for which Predictions should be fetched.
  ///   - completionHandler: Closure that receives a Result object containing an array of Predictions but returns nothing.
  func getPredictions(forStop stopId: Int, completionHandler: @escaping (Result<[Prediction]>) -> Void) {
    Alamofire.request(MetroRouter.getPredictions(stopId))
      .responseJSON { response in
        let result = self.buildPredictionsArray(response: response)
        
        completionHandler(result)
    }
  }
  
  /// Convert response to Result with array of Predictions.
  ///
  /// - Parameter response: DataResponse of type Any. This should be the raw response object from **getPredictions(forStop:completionHandler:)**
  /// - Returns: Result object of type Prediction array.
  private func buildPredictionsArray(response: DataResponse<Any>) -> Result<[Prediction]> {
    
    guard response.result.error == nil else {
      debugPrint(response.result.error!)
      return .failure(PredictionRouterError.routingError(reason: "Network error: \(response.result.error!)"))
    }
    
    guard let json = response.result.value else {
      return .failure(PredictionRouterError.routingError(reason: "No value was returned from the API."))
    }
    
    let rawResult = JSON(json)
    let results = rawResult["items"].arrayValue
    
    var predictions = [Prediction]()
    
    for result in results {
      if let prediction = Prediction(json: result) {
        predictions.append(prediction)
      } else {
        return .failure(PredictionRouterError.serializationError(reason: "Unable to serialize predictions."))
      }
    }
    
    return .success(predictions)
  }
  
  
  // MARK: - GET Train Location
  
  /// Retrieve a Vehicle's location.
  ///
  /// - Parameters:
  ///   - trainId: ID of the train for which you want Predictions.
  ///   - completionHandler: Closure that receives a Result object containing a single VehicleLocation but returns nothing.
  func getTrainLocation(forTrainId trainId: Int, completionHandler: @escaping (Result<VehicleLocation>) -> Void) {
    Alamofire.request(MetroRouter.getVehicleInfo(trainId))
      .responseJSON { response in
        let vehicle = self.createVehicleLocation(fromResponse: response, withTrainID: trainId)
        
        completionHandler(vehicle)
    }
  }
  
  /// Convert response to Result with VehicleLocation.
  ///
  /// - Parameters:
  ///   - response: DataResponse of type Any. This should be the raw response object from **getTrainLocation(forTrainId:completionHandler:)**
  ///   - trainId: Ensures link between created VehicleLocation and train ID used to fetch data.
  /// - Returns: Result object containing a single VehicleLocation.
  private func createVehicleLocation(fromResponse response: DataResponse<Any>, withTrainID trainId: Int) -> Result<VehicleLocation> {
    guard response.result.error == nil else {
      debugPrint(response.result.error!)
      return .failure(PredictionRouterError.routingError(reason: "Network error: \(response.result.error!)"))
    }
    
    guard let rawJson = response.result.value else {
      return .failure(PredictionRouterError.routingError(reason: "No value was returned from the API."))
    }
    
    let json = JSON(rawJson)
    
    if let vehicle = Vehicle(withJson: json, forTrainID: trainId) {
      let title = "Vehicle \(vehicle.id) on route \(vehicle.routeId)"
      let subtitle = "Location age: \(vehicle.secondsSinceReport)"
      let vehicleLocation = VehicleLocation(vehicle: vehicle, title: title, subtitle: subtitle)
      return .success(vehicleLocation)
    } else {
      return .failure(PredictionRouterError.serializationError(reason: "Could not turn JSON into a Vehicle"))
    }
  }
  
  
  // MARK: - GET Stops for Given Line
  
  /// Retrieve all Stops for a given TrainLine.
  ///
  /// - Parameters:
  ///   - line: TrainLine object for which you want all Stops.
  ///   - completionHandler: Closure that receives a Result object containing an array of Stops but returns nothing.
  func getStops(forLine line: TrainLine, completionHandler: @escaping (Result<[Stop]>) -> Void) {
    Alamofire.request(MetroRouter.getStops(line))
      .responseJSON { result in
        let stops = self.buildStopsArray(fromResponse: result, forLine: line)
        
        completionHandler(stops)
    }
  }
  
  /// Convert response to an array of Stops.
  ///
  /// - Parameters:
  ///   - response: DataResponse of type Any. This should be the raw response object from **getStops(forLine:completionHandler:)**
  ///   - line: TrainLine object required to ensure link between Stops and TrainLine used to generate them.
  /// - Returns: Result object containing an array of Stops.
  private func buildStopsArray(fromResponse response: DataResponse<Any>, forLine line: TrainLine) -> Result<[Stop]> {
    guard response.result.error == nil else {
      debugPrint(response.result.error!)
      return .failure(PredictionRouterError.routingError(reason: "Network error: \(response.result.error!)"))
    }
    
    guard let json = response.result.value else {
      return .failure(PredictionRouterError.routingError(reason: "No value was returned from the API."))
    }
    
    let rawResult = JSON(json)
    let results = rawResult["items"].arrayValue
    
    var stops = [Stop]()
    
    for result in results {
      stops.append(Stop(forLine: line, fromJSON: result))
    }
    
    return .success(stops)
  }
  
}
