//
//  PredictionRouter.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation
import Alamofire

enum MetroRouter: URLRequestConvertible {
  
  // MARK: - Routes
  
  case getPredictions(Int)
  case getVehicleInfo(Int)
  
  // MARK: - URL Components
  
  var baseUrl: String {
    return "https://api.metro.net/"
  }
  
  var method: HTTPMethod {
    return .get
  }
  
  var relativePath: String {
    
    switch self {
    case .getPredictions(let stopId):
      return "agencies/\(LAMetro.agency)/stops/\(stopId)/predictions/"
      
    case .getVehicleInfo(let trainId):
      return "/agencies/\(LAMetro.agency)/vehicles/\(trainId)/"
    }
  }
  
  var parameters: Parameters? {
    return nil
  }
  
  var headers: [String: String] {
    var headers = [String: String]()
    
    headers["Content-Type"] = "application/json"
    headers["Accept"] = "application/json"
    
    return headers
  }
  
  // MARK: - Methods
  
  func asURLRequest() throws -> URLRequest {
    guard let url = URL(string: baseUrl) else {
      throw PredictionRouterError.routeCreationError(reason: "Unable to convert baseUrl to URL object.")
    }
    
    let fullUrl = url.appendingPathComponent(relativePath)
    
    var request = URLRequest(url: fullUrl)
    request.httpMethod = method.rawValue
    
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }
    
    let encoding = URLEncoding.default
    
    return try encoding.encode(request, with: nil)
  }
  
  
}


// MARK: - PredictionRouterError

enum PredictionRouterError: Error {
  
  // MARK: - Error Cases
  
  case invalidStopId(id: Int, reason: String)
  case routingError(reason: String)
  case routeCreationError(reason: String)
  case serializationError(reason: String)
}
