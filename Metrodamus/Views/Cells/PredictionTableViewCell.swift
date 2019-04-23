//
//  PredictionTableViewCell.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/14/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class PredictionTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var directionLabel: UILabel!
  @IBOutlet weak var directionImage: UIImageView!
  @IBOutlet weak var etaLabel: UILabel!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK: - Methods
  
  func configure(withPrediction prediction: Prediction) {
    
    let image = getDirectionImage(fromDirection: prediction.direction)
    
    let eta = buildEtaLabelText(withTime: prediction.minutes)
    
    directionLabel.text = prediction.direction
    directionImage.image = image
    etaLabel.text = eta
    etaLabel.textColor = getEtaLabelTextColor(forDelay: prediction.age)
  }
  
  private func getDirectionImage(fromDirection direction: String) -> UIImage {
    let image: UIImage
    
    let homeIcon = UIImage(named: "icon_home")
    let workIcon = UIImage(named: "icon_work")
    let defaultImage = UIImage(named: "icon_close_small")
    
    if direction == "Home" {
      image = homeIcon!
    } else if direction == "Work" {
      image = workIcon!
    } else {
      image = defaultImage!
    }
    
    return image
  }
  
  private func buildEtaLabelText(withTime time: Int) -> String {
    return "\(time)min"
  }
  
  private func getEtaLabelTextColor(forDelay delay: Int) -> UIColor {
    switch delay {
    case 0...45:
      return UIColor.green
    case 46...80:
      return UIColor(hue: 47, saturation: 97, brightness: 91, alpha: 1.0)
    default:
      return UIColor.red
    }
  }
}
