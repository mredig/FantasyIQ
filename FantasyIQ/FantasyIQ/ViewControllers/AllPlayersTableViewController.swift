//
//  AllPlayersTableViewController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class AllPlayersTableViewController: UITableViewController {
    
    @IBOutlet var addPlayersButton: UIButton!
    @IBOutlet var searchAllPlayers: UISearchBar!
    
    var fantasyController: FantasyIQController?
    var addedPlayer: AllPossiblePlayers?
    var team: [SeasonProjection] = []
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppearanceHelper.style(button: addPlayersButton)
        guard let fantasyController = fantasyController else {return}
        fantasyController.fetchAllPlayers { (_, _) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fantasyController = fantasyController else {return 0}
        return fantasyController.allFantasyPlayers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllPlayerCell", for: indexPath) as? AllPlayersTableViewCell, let fantasyController = fantasyController else {return UITableViewCell()}
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
        let player = fantasyController.allFantasyPlayers[indexPath.row]
        cell.buttonAction =  { (sender) in
            self.count += 1
            self.title = "You Have \(self.count) Players Selected"
            self.addedPlayer = player
            self.turnAddedPlayerToSeasonProjection(addedPlayer: player)
        }
        cell.nameLabel.text = player.Name
        cell.teamLabel.text = player.Team
        return cell
    }
    
    @IBAction func addPlayersTapped(_ sender: UIButton) {
        guard let fantasyController = fantasyController else {return}
        for player in team {
            fantasyController.addPlayerToFirebase(with: player) {
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func turnAddedPlayerToSeasonProjection(addedPlayer: AllPossiblePlayers) {
        guard let fantasyController = fantasyController, let name = addedPlayer.Name else {return}
        fantasyController.fetchPlayerAndProjectedSeasonStats(playerName: name) { (seasonprojection, error) in
            if let error = error {
                NSLog("Error turning added player into season projection: \(error)")
                return
            }
            guard let teamPlayer = seasonprojection else {return}
            self.team.append(teamPlayer)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindSegue" {
        }
    }
    
    
    
    
}
