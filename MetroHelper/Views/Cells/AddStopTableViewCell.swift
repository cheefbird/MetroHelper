//
//  AddStopTableViewCell.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 2/3/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class AddStopTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var contentContainer: UIView!
  @IBOutlet weak var lineDisplayName: UILabel!
  @IBOutlet weak var stopDisplayName: UILabel!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
