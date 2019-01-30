//
//  PredictionData.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import Foundation

struct PredictionData {
  let sampleData: [Prediction]

  init() {
    let sampleOne = Prediction(seconds: 647, minutes: 10, routeId: 804, runId: "804_1_var0", trainId: 111)
    let sampleTwo = Prediction(seconds: 1105, minutes: 18, routeId: 804, runId: "804_1_var0", trainId: 222)
    let sampleThree = Prediction(seconds: 174, minutes: 2, routeId: 804, runId: "804_0_var0", trainId: 333)
    let sampleFour = Prediction(seconds: 894, minutes: 14, routeId: 804, runId: "804_0_var0", trainId: 444)

    let sample = [sampleOne, sampleTwo, sampleThree, sampleFour]

    sampleData = sample
  }
}
