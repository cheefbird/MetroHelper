//
//  StopTableViewCell.swift
//  MetroHelper
//
//  Created by Francis Breidenbach on 1/3/19.
//  Copyright © 2019 Francis Breidenbach. All rights reserved.
//

import UIKit

class StopTableViewCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var stopLabel: UILabel!
  
  // MARK: - Overrides
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  // MARK: - Configure
  
  func configure(forStop stop: StopObject) {
    let customAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 16))
    customAccessoryView.image = UIImage(named: "icon_detail")!
    customAccessoryView.tintColor = UIColor(named: "darkGray")
    
    self.accessoryView = customAccessoryView
    
    self.stopLabel.text = stop.displayName
  }
}
