//
//  AllPlayersTableViewController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class AllPlayersTableViewController: UITableViewController {
    
    @IBOutlet var searchAllPlayers: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllPlayerCell", for: indexPath) as? AllPlayersTableViewCell else {return UITableViewCell()}
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
        cell.addButton.addTarget(self, action: #selector(performSegueToRosterView), for: .touchUpInside)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindSegue" {
        }
    }
    
    @objc func performSegueToRosterView() {
        self.performSegue(withIdentifier: "UnwindSegue", sender: self)
    }
}
