//
//  FantasyIQController.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import Firebase

class FantasyIQController {
    var allFantasyPlayers: [AllPossiblePlayers] = []
    var projectedSeasonStats: SeasonProjection?
    var projectedGameStats: GameProjection?
    var team: [SeasonProjection] = []
    var currentWeek: Int?
    var upComingWeek: Int?
    var currentPlayerGameStats: CurrentPlayerStats?
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
    func fetchPlayerAndProjectedSeasonStats(playerName: String,completion: @escaping (SeasonProjection?, Error?) -> Void = {_,_ in}) {
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
                let receivedData = try JSONDecoder().decode(SeasonProjection.self, from: data)
                self.projectedSeasonStats = receivedData
                completion(self.projectedSeasonStats, nil)
            } catch {
                NSLog("Error decoding projected season stats: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func fetchCurrentPlayerGameStats(playerID: Int?, completion: @escaping(CurrentPlayerStats?, Error?) -> Void = {_,_ in}) {
        guard let id = playerID, let week = currentWeek else {return}
        let requestURL = fantasyDataBaseURL.appendingPathComponent("stats").appendingPathComponent("json").appendingPathComponent("PlayerGameStatsByPlayerID").appendingPathComponent("2019REG").appendingPathComponent("\(week)").appendingPathComponent("\(id)")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching player game stats: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error with data trying to fetch player game stats")
                completion(nil, error)
                return
            }
            do {
                self.currentPlayerGameStats = try JSONDecoder().decode(CurrentPlayerStats.self, from: data)
                completion(self.currentPlayerGameStats, nil)
            } catch {
                NSLog("Error decoding current player game stats:\(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func fetchCurrentWeek(completion: @escaping(Int?,Error?) -> Void = {_,_ in}) {
        let requestURL = fantasyDataBaseURL.appendingPathComponent("scores").appendingPathComponent("json").appendingPathComponent("CurrentWeek")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching current week: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error with data fetching current week")
                completion(nil, error)
                return
            }
            do {
                self.currentWeek = try JSONDecoder().decode(Int.self, from: data)
                completion(self.currentWeek, nil)
            } catch {
                NSLog("Error decoding current week :\(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func fetchUpcomingWeek(completion: @escaping(Int?,Error?) -> Void = {_,_ in}) {
        let requestURL = fantasyDataBaseURL.appendingPathComponent("scores").appendingPathComponent("json").appendingPathComponent("UpcomingWeek")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching upcoming week: \(error)")
                completion(nil,error)
                return
            }
            guard let data = data else {
                NSLog("Error with data fetching upcoming week")
                completion(nil,error)
                return
            }
            do {
                self.upComingWeek = try JSONDecoder().decode(Int.self, from: data)
                completion(self.upComingWeek, nil)
            } catch {
                NSLog("Error decoding upcoming week :\(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    func fetchProjectedGameStats(playerID: Int, completion: @escaping(GameProjection?,Error?) -> Void = {_,_ in}) {
        guard let week = currentWeek else {return}
        let requestURL = fantasyDataBaseURL.appendingPathComponent("projections").appendingPathComponent("json").appendingPathComponent("PlayerGameProjectionStatsByPlayerID").appendingPathComponent("2019REG").appendingPathComponent("\(week)").appendingPathComponent("\(playerID)")
        var request = URLRequest(url: requestURL)
        request.setValue("b01c6298fc2d438189d7664eded318c9", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching projected game: \(error)")
                completion(nil,error)
                return
            }
            guard let data = data else {
                NSLog("Error with data for projected game")
                completion(nil,error)
                return
            }
            do {
                self.projectedGameStats = try JSONDecoder().decode(GameProjection.self, from: data)
                completion(self.projectedGameStats, nil)
            } catch {
                NSLog("Error decoding projected stats :\(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
    
    func playerProjectedSeasonPoints(playerSeasonProjection: SeasonProjection) -> Double {
        guard let projectedFantasyPoints = playerSeasonProjection.FantasyPoints else {return 0}
        return projectedFantasyPoints
    }
    
    func playerProjectedGamePoints(playerGameProjection: GameProjection) -> Double {
        guard let projectedFantasyPoints = playerGameProjection.FantasyPoints else {return 0}
        return projectedFantasyPoints
    }
    
    func calculateDepthChartRankingForQB(team: [SeasonProjection]) -> String {
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
    
    
    func calculateDepthChartRankingForWR(team: [SeasonProjection]) -> String {
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
    
    func calculateDepthChartRankingForRB(team: [SeasonProjection]) -> String {
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
    
    func calculateTradeCombinations(team: [SeasonProjection]) -> String {
        
        if calculateDepthChartRankingForQB(team: team) == "Weak" {
            return "Trade one high value player or two medium valued players for a QB"
        } else if  calculateDepthChartRankingForRB(team: team) == "Weak" {
            return "Trade one high value player or two medium valued players for a RB"
        } else if calculateDepthChartRankingForWR(team: team) == "Weak" {
            return "Trade one high value player or two medium valued players for a WR"
        }
        return ""
    }
    
    func calculatePotentialBreakoutPlayers(allPlayers: [AllPossiblePlayers]) -> String {
        var playerGameStats: [CurrentPlayerStats] = []
        for n in allPlayers {
            fetchCurrentPlayerGameStats(playerID: n.PlayerID) { (currentplayerstats, error) in
                guard let playerStats = currentplayerstats else {return}
                playerGameStats.append(playerStats)
            }
        }
        for player in playerGameStats {
            guard let points = player.FantasyPoints else {return ""}
            if points >= 17.0 {
                return "\(player.Name) is having a breakout game!"
            }
        }
        return ""
    }
    
//    func createTeam(with team: [SeasonProjection], completion: @escaping () -> Void) {
//        let ref = Database.database().reference(withPath: "Team")
//        let team = Team(identifier: UUID().uuidString, team: team)
//        ref.setValue(team.toAnyObject())
//        completion()
//    }
    
    func fetchTeam(completion: @escaping () -> Void) {
        let ref = Database.database().reference(withPath: "Team")
        ref.observe(.value, with: { snapshot in
            for playerNode in snapshot.children {
                if let dataSnap = playerNode as? DataSnapshot,
                    let player = SeasonProjection(snapshot: dataSnap) {
                    self.team.append(player)
                }
            }
            completion()
        })
    }
    
    func addPlayerToFirebase(with player: SeasonProjection, completion: @escaping () -> Void) {
        let ref = Database.database().reference(withPath: "Team/\(player.identifier)")
        ref.setValue(player.toAnyObject())
        completion()
    }
}

