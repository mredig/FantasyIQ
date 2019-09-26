//
//  Player.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import Firebase


struct AllPossiblePlayers: Codable {
    var PlayerID: Int
    var Team: String?
    var Name: String?
    var Position: String?
    var ByeWeek: Int?
}

struct CurrentPlayerStats: Codable {
    var Team: String
    var PlayerID: Int?
    var Opponent: String
    var HomeOrAway: String
    var Number: Int?
    var Name: String
    var Position: String
    var Activated: Int?
    var FantasyPoints: Double?
}


class SeasonProjection: Codable, Equatable {
    var identifier: String?
    var PlayerID: Int
    var Team: String?
    var Season: Int?
    var Name: String?
    var Position: String?
    var FantasyPoints: Double?
    
    init(identifier: String = UUID().uuidString, PlayerID: Int, Team: String?, Season: Int?, Name: String?, Position: String?, ByeWeek: Int?, FantasyPoints: Double?) {
        self.PlayerID = PlayerID
        self.identifier = identifier
        self.Team = Team
        self.Season = Season
        self.Name = Name
        self.Position = Position
        self.FantasyPoints = FantasyPoints
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let PlayerID = try container.decode(Int.self, forKey: .PlayerID)
        let Team = try container.decode(String.self, forKey: .Team)
        let Season = try container.decode(Int.self, forKey: .Season)
        let Name = try container.decode(String.self, forKey: .Name)
        let Postion = try container.decode(String.self, forKey: .Position)
        let FantasyPoints = try container.decode(Double.self, forKey: .FantasyPoints)
        
        self.PlayerID = PlayerID
        self.Team = Team
        self.Season = Season
        self.Name = Name
        self.Position = Postion
        self.FantasyPoints = FantasyPoints
    }
    static func ==(lhs: SeasonProjection, rhs: SeasonProjection) -> Bool {
    return
        lhs.PlayerID == rhs.PlayerID &&
        lhs.identifier == rhs.identifier &&
        lhs.Team == rhs.Team &&
        lhs.Season == rhs.Season &&
        lhs.Name == rhs.Name &&
        lhs.Position == rhs.Position &&
        lhs.FantasyPoints == rhs.FantasyPoints
        
    }
    func toAnyObject() -> Any {
        
        return [
            "PlayerID": PlayerID,
            "identifier": identifier,
            "Team": Team ?? "No Team",
            "Season": Season ?? 0,
            "Name": Name ?? "Name not available",
            "Position": Position ?? "Position Not Available",
            "FantasyPoints": FantasyPoints ?? 0
        ]
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
        let identifier = value["identifier"] as? String,
        let PlayerID = value["PlayerID"] as? Int,
        let Team = value["Team"] as? String,
        let Season = value["Season"] as? Int,
        let Name = value["Name"] as? String,
        let Postion = value["Position"] as? String,
        let ByeWeek = value["ByeWeek"] as? Int,
        let FantasyPoints = value["FantasyPoints"] as? Double
            else {
                return nil
        }
        self.identifier = identifier
        self.PlayerID = PlayerID
        self.Team = Team
        self.Season = Season
        self.Name = Name
        self.Position = Postion
        self.FantasyPoints = FantasyPoints
  }
}

struct GameProjection: Codable {
    var Team: String
    var PlayerID: Int?
    var Opponent: String
    var HomeOrAway: String
    var Number: Int?
    var Name: String
    var Position: String
    var Activated: Int?
    var FantasyPoints: Double?
}

struct Defense: Codable {
    var Season: Int
    var Week: Int
    var Team: String
    var Opponent: String
    var PointsAllowed: Int
    var TouchdownsScored: Int
    var FantasyPointsAllowed: Int
    var FantasyPoints: Int
}

struct AllPlayers: Codable {
    var PlayerID: Int
    var Name: String
    var Team: String
    var position: String
    var ByeWeek: Int
}
