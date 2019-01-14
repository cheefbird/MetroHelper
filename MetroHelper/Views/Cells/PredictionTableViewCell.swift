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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
