//
//  FantasyIQController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

class FantasyIQController {
    
    var allFantasyPlayers: [AllPossiblePlayers] = []
    var projectedSeasonStats: Player?
    var projectedGameStats: Player?
    let fantasyDataBaseURL = URL(string: "https://api.sportsdata.io/v3/nfl/")!
    
    func fetchAllPlayers(completion: @escaping ([AllPossiblePlayers]?, Error?) -> Void = {_,_ in}) {
        let requestURL = fantasyDataBaseURL.appendingPathComponent("stats").appendingPathComponent("json")  .appendingPathComponent("FantasyPlayers")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetch all fantasy players: \(error)")
                completion(nil,error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from fetching all fantasy players data task")
                completion(nil, NSError())
                return
            }
            do {
                self.allFantasyPlayers =  try JSONDecoder().decode([AllPossiblePlayers].self, from: data)
                completion(self.allFantasyPlayers, nil)
            } catch {
                NSLog("Error decoding json data for fetching all fantasy players: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
        
    }
    
    //in the arguments you have to take the name of the player, in the body before the request find the corresponding player id and use in url
    func fetchProjectedSeasonStats(playerName: String,completion: @escaping (Player?, Error?) -> Void = {_,_ in}) {
        //projections/json/PlayerSeasonProjectionStatsByPlayerID/2019REG/14986
         let player = allFantasyPlayers.filter{$0.Name == playerName}.first
        guard let id = player?.PlayerID else {return}
        let requestURL = fantasyDataBaseURL.appendingPathComponent("projections").appendingPathComponent("json").appendingPathComponent("PlayerSeasonProjectionStatsByPlayerID").appendingPathComponent("2019REG").appendingPathComponent("\(id)")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching player projected season stats: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
            NSLog("Error fetching data for projected season stats: \(error!)")
                completion(nil, error)
                return
            }
            do {
                let receivedData = try JSONDecoder().decode(Player.self, from: data)
                self.projectedSeasonStats = receivedData
                completion(self.projectedSeasonStats, nil)
            } catch {
                NSLog("Error decoding projected season stats: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
    func calculatePlayerRating(player: Player) {
        
    }
    
}
