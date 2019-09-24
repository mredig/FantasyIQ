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
    var team: [Player] = []
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
    func fetchPlayerAndProjectedSeasonStats(playerName: String,completion: @escaping (Player?, Error?) -> Void = {_,_ in}) {
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
                self.team.append(receivedData)
                completion(self.projectedSeasonStats, nil)
            } catch {
                NSLog("Error decoding projected season stats: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
   
    
    func playerProjectedSeasonPoints(playerSeasonProjection: Player) -> Double {
        guard let projectedFantasyPoints = playerSeasonProjection.FantasyPoints else {return 0}
        return projectedFantasyPoints
    }
    
    func playerProjectedGamePoints(playerGameProjection: Player) -> Double {
        guard let projectedFantasyPoints = playerGameProjection.FantasyPoints else {return 0}
        return projectedFantasyPoints
    }
    
    func calculateDepthChartRankingForQB(team: [Player]) -> String {
        let allQBs = team.filter{$0.Position!.contains("QB")}
        for qb in allQBs {
            guard let seasonFantasyPoints = qb.FantasyPoints else { NSLog("Error getting qb depth ranking");return ""}
            if seasonFantasyPoints >= 300.0 && allQBs.count >= 2 {
                return "Strong"
            } else if seasonFantasyPoints >= 200.0 && seasonFantasyPoints < 300 && allQBs.count < 2 {
                return "Medium"
            } else {
                return "Weak"
            }
        }
        return ""
    }
    
    
       func calculateDepthChartRankingForWR(team: [Player]) -> String {
           let allwrs = team.filter{$0.Position!.contains("WR")}
           for wr in allwrs {
               guard let seasonFantasyPoints = wr.FantasyPoints else { NSLog("Error getting WR depth ranking");return ""}
               if seasonFantasyPoints >= 250.0 && allwrs.count >= 2 {
                   return "Strong"
               } else if seasonFantasyPoints >= 150.0 && seasonFantasyPoints < 300 && allwrs.count < 2 && allwrs.count > 0 {
                   return "Medium"
               } else {
                   return "Weak"
               }
           }
           return ""
       }
       
    func calculateDepthChartRankingForRB(team: [Player]) -> String {
        let allrbs = team.filter{$0.Position!.contains("RB")}
        for rb in allrbs {
            guard let seasonFantasyPoints = rb.FantasyPoints else { NSLog("Error getting RB depth ranking");return ""}
            if seasonFantasyPoints >= 250.0 && allrbs.count >= 2 {
                return "Strong"
            } else if seasonFantasyPoints >= 150.0 && seasonFantasyPoints < 300 && allrbs.count < 2 && allrbs.count > 0 {
                return "Medium"
            } else {
                return "Weak"
            }
        }
        return ""
    }
    
    func calculateTradeCombinations(team: [Player]) -> String {
       
        if calculateDepthChartRankingForQB(team: team) == "Weak" {
            return "Trade one high value player or two medium valued players for a QB"
        } else if  calculateDepthChartRankingForRB(team: team) == "Weak" {
            return "Trade one high value player or two medium valued players for a RB"
        } else if calculateDepthChartRankingForWR(team: team) == "Weak" {
           return "Trade one high value player or two medium valued players for a WR"
        }
       return ""
    }
}
