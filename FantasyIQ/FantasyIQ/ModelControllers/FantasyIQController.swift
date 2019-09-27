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
    var receivedPlayers: [SeasonProjection] = []
    var currentWeek: Int?
    var receviedTeam: Team?
    var upComingWeek: Int?
    var currentPlayerGameStats: CurrentPlayerStats?
    let fantasyDataBaseURL = URL(string: "https://api.sportsdata.io/v3/nfl/")!
    let baseURL = URL(string: "https://fantasyiq-d5291.firebaseio.com/")!
    
    
    func createPlayer(fantasyPoints: Double,
                      identifier: String = UUID().uuidString,
                      name: String,
                      playerID: Int16,
                      position: String,
                      season: Int16,
                      team: String) {
        let newPlayer = Player(name: name, fantasyPoints: fantasyPoints, playerID: playerID, position: position, season: season, identifier: identifier, team: team, context: CoreDataStack.shared.mainContext)
        saveToCoreData()
        
    }
    
    func deletePlayer(player: Player) {
        let moc = CoreDataStack.shared.mainContext
        moc.delete(player)
        saveToCoreData()
    }
    
    func createPlayerGameProjection(fantasyPoints: Double, acitvated: Int16, homeAway: String, identifier: String = UUID().uuidString, name: String, number:Int16, opponent: String, playerID: Int16, position: String, team: String ) {
        let newPlayerGameProjection = PlayerGame(name: name, fantasyPoints: fantasyPoints, playerID: playerID, position: position, activated: acitvated, identifier: identifier, team: team, opponent: opponent, number: number, homeAway: homeAway, context: CoreDataStack.shared.mainContext)
        saveToCoreData()
    }
    
    func saveToCoreData() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        }catch {
            NSLog("Error saving to core data \(error)")
                moc.reset()
        }
    }
    
    
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
    
    func calculateDepthChartRankingForQB(team: [Player]) -> String {
        let allQBs = team.filter{$0.position!.contains("QB")}
        for qb in allQBs {
            if qb.fantasyPoints >= 300.0 && allQBs.count >= 2 {
                return "Strong"
            } else if qb.fantasyPoints >= 200.0 {
                return "Medium"
            } else {
                return "Weak"
            }
        }
        return ""
    }
    
    
    func calculateDepthChartRankingForWR(team: [Player]) -> String {
        let allwrs = team.filter{$0.position!.contains("WR")}
        for wr in allwrs {
          
            if wr.fantasyPoints >= 250.0 && allwrs.count >= 2 {
                return "Strong"
            } else if wr.fantasyPoints >= 150.0 && allwrs.count < 2 && allwrs.count > 0 {
                return "Medium"
            } else {
                return "Weak"
            }
        }
        return ""
    }
    
    func calculateDepthChartRankingForRB(team: [Player]) -> String {
        let allrbs = team.filter{($0.position?.contains("RB"))!}
        for rb in allrbs {
            
            if rb.fantasyPoints >= 250.0 && allrbs.count >= 2 {
                return "Strong"
            } else if rb.fantasyPoints >= 150.0 && allrbs.count < 2 && allrbs.count > 0 {
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
    
    func createTeam(with team: [SeasonProjection], completion: @escaping () -> Void) {
        let id = UUID().uuidString
        let ref = Database.database().reference(withPath: "Team").child("\(id)").child("players")
        let userTeam = Team(identifier: id, team: team)
        ref.setValue(userTeam.toAnyObject()) { (_, _) in
              completion()
        }
    }
    
    func fetchTeams(completion: @escaping () -> Void) {
        let ref = Database.database().reference(withPath: "Team")
        ref.observe(.value, with: { snapshot in
            for teamNode in snapshot.children {
                if let dataSnap = teamNode as? DataSnapshot,
                    let team = Team(snapshot: dataSnap),
                    let players = team.players {
                    self.receivedPlayers = players
                    self.receviedTeam = team
                }
            }
            completion()
        })
    }
    func addPlayerToFirebase(team: Team, with player: SeasonProjection, completion: @escaping () -> Void) {
        guard let id = team.identifier else {return
        }
        let ref = Database.database().reference(withPath: "Team").child(id).child("players")
        ref.setValue(player.toAnyObject()) { (_, _) in
             completion()
        }
    }
}

