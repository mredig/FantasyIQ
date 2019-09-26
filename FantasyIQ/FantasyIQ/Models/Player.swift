//
//  Player.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation


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


struct SeasonProjection: Codable {
    var PlayerID: Int
    var Team: String?
    var Season: Int?
    var Name: String?
    var Position: String?
    var ByeWeek: Int?
    var FantasyPoints: Double?
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
