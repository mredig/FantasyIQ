//
//  AppearanceHelper.swift
//  playerIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceHelper {

static var playerBlack = #colorLiteral(red: 0.01176470588, green: 0.01176470588, blue: 0.01176470588, alpha: 1)
static var playerNeonBlue = #colorLiteral(red: 0.07450980392, green: 0.8196078431, blue: 0.6784313725, alpha: 1)
    
   
    static func setDarkAppearance() {
        UINavigationBar.appearance().tintColor = playerNeonBlue
        UINavigationBar.appearance().barTintColor = playerBlack
        UINavigationBar.appearance().backgroundColor = playerBlack
        UITextField.appearance().backgroundColor = playerNeonBlue
        UITableView.appearance().backgroundColor = playerBlack
    }
    
    
    static func style(button: UIButton) {
           button.backgroundColor = playerNeonBlue
           button.setTitleColor(.white, for: .normal)
           button.layer.cornerRadius = 10
       }
    
}
