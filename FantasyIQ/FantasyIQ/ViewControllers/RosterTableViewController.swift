//
//  RosterTableViewController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import Foundation

class RosterTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RosterPlayerCell", for: indexPath) as? RosterTableViewCell else { print("Error loading cell");return UITableViewCell()}
        cell.cardView.layer.shadowRadius = 30
        cell.cardView.backgroundColor = .white
        cell.cardView.layer.cornerRadius = 15
        cell.cardView.layer.shadowOpacity = 5
        cell.cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.cardView.layer.shadowColor = #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
        cell.cardView.layer.borderWidth = 0.2
        cell.cardView.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.8078431373, blue: 0.8078431373, alpha: 1)
        cell.backgroundColor = AppearanceHelper.playerBlack
        cell.cardView.backgroundColor = AppearanceHelper.playerBlack
        return cell
    }

    @IBAction func unwindto(segue: UIStoryboardSegue) {
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     }
    
}
