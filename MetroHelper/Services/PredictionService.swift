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

class PredictionService {
  
  // MARK: - Properties
  
  static let sharedInstance = PredictionService()
  
  // MARK: - Init
  
  private init() {}
  
  // MARK: - GET Predictions
  
  func getPredictions(forStop stopId: Int, completionHandler: @escaping (Result<[Prediction]>) -> Void) {
    Alamofire.request(PredictionRouter.getPredictions(stopId))
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
  
}
