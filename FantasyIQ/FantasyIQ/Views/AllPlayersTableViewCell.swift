//
//  AllPlayersTableViewCell.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class AllPlayersTableViewCell: UITableViewCell {

    @IBOutlet var playerImage: UIImageView!
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var teamLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var buttonAction: ((_ sender: AnyObject) -> Void)?
   
    @IBAction func addPlayerTapped(_ sender: UIButton) {
       self.buttonAction?(sender)
    }
    
    
}
