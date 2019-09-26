//
//  RosterTableViewCell.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import Foundation
class RosterTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var playerHeadShotImage: UIImageView!
    @IBOutlet var projectedSeasonPointsLabel: UILabel!
    @IBOutlet var projectedGamePointsLabel: UILabel!
    
    @IBOutlet var byeWeekLabel: UILabel!
    
    @IBOutlet var activatedLabel: UILabel!
    
    @IBOutlet var cardView: UIView!
    
    func configure() {
        
    }

}
