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
  
  func getPredictions(forStop stopId: Int, completionHandler: @escaping (Result<[Prediction]>) -> Void) {
    Alamofire.request(MetroRouter.getPredictions(stopId))
      .responseJSON { response in
        let result = self.buildPredictionsArray(response: response)
        
        completionHandler(result)
    }
  }
  
  private func buildPredictionsArray(response: DataResponse<Any>) -> Result<[Prediction]> {
    
    guard response.result.error == nil else {
      print(response.result.error!)
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
    
    print(predictions)
    
    return .success(predictions)
  }
  
  
  // MARK: - GET Train Location
  
  func getTrainLocation(forTrainId trainId: Int, completionHandler: @escaping (Result<VehicleLocation>) -> Void) {
    Alamofire.request(MetroRouter.getVehicleInfo(trainId))
      .responseJSON { response in
        let vehicle = self.createVehicleLocation(fromResponse: response, withTrainID: trainId)
        
        completionHandler(vehicle)
    }
  }
  
  private func createVehicleLocation(fromResponse response: DataResponse<Any>, withTrainID trainId: Int) -> Result<VehicleLocation> {
    guard response.result.error == nil else {
      print(response.result.error!)
      return .failure(PredictionRouterError.routingError(reason: "Network error: \(response.result.error!)"))
    }
    
    guard let rawJson = response.result.value else {
      return .failure(PredictionRouterError.routingError(reason: "No value was returned from the API."))
    }
    
    let json = JSON(rawJson)
    
    if let vehicle = Vehicle(withJson: json, forTrainID: trainId) {
      let title = "Vehicle \(vehicle.routeId) Location"
      let vehicleLocation = VehicleLocation(vehicle: vehicle, title: title)
      return .success(vehicleLocation)
    } else {
      return .failure(PredictionRouterError.serializationError(reason: "Could not turn JSON into a Vehicle"))
    }
  }
  
  
  // MARK: - GET Stops for Given Line
  
  func getAllStops(forLine line: TrainLine, completionHandler: @escaping (Result<[Stop]>) -> Void) {
    Alamofire.request(MetroRouter.getStops(line))
      .responseJSON { result in
        let stops = self.buildStopsArray(fromResponse: result, forLine: line)
        
        completionHandler(stops)
    }
  }
  
  private func buildStopsArray(fromResponse response: DataResponse<Any>, forLine line: TrainLine) -> Result<[Stop]> {
    guard response.result.error == nil else {
      print(response.result.error!)
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
