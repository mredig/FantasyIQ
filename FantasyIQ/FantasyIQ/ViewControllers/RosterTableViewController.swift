//
//  RosterTableViewController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/25/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class RosterTableViewController: UITableViewController {
    
    let fantasyController = FantasyIQController()
    
    lazy var fetchedRC: NSFetchedResultsController<Player> = {
           let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        let positionSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        fetchRequest.sortDescriptors = [positionSortDescriptor]
           let moc = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
           frc.delegate = self
           do {
               try frc.performFetch()
           }catch {
               fatalError()
           }
           return frc
       }()
    
    lazy var fetchedRCForGameProjection: NSFetchedResultsController<PlayerGame> = {
        let fetchRequest: NSFetchRequest<PlayerGame> = PlayerGame.fetchRequest()
     let positionSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "position", ascending: true)
     fetchRequest.sortDescriptors = [positionSortDescriptor]
        let moc = CoreDataStack.shared.mainContext
     let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do {
            try frc.performFetch()
        }catch {
            fatalError()
        }
        return frc
    }()
    
    @IBOutlet var calculcateTradeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  AppearanceHelper.style(button: calculcateTradeButton)
      
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedRC.sections?[section].name.capitalized
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedRC.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedRC.fetchedObjects?.count ?? 0
        
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
        let player = fetchedRC.object(at: indexPath)
//        let playerGame = fetchedRCForGameProjection.object(at: indexPath)
//            cell.numberLabel.text = "\(playerGame.number)"
//            cell.projectedGamePointsLabel.text = "\(playerGame.fantasyPoints)"
        cell.nameLabel.text = player.name
        cell.projectedSeasonPointsLabel.text = "\(player.fantasyPoints)"
        cell.teamLabel.text = "\(player.team!)"
        return cell
    }
    @IBAction func unwindto(segue: UIStoryboardSegue) {
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddPlayer" {
            guard let destinationVC = segue.destination as? AllPlayersTableViewController else {return}
            destinationVC.fantasyController = fantasyController
        }
     }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let player = fetchedRC.object(at: indexPath)
            fantasyController.deletePlayer(player: player)
        }
    }
    
}
extension RosterTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .fade)
        @unknown default:
            fatalError()
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let sectionnIndexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(sectionnIndexSet, with: .fade)
        case .delete:
            tableView.deleteSections(sectionnIndexSet, with: .fade)
            
        default:
            break
        }
    }
}
