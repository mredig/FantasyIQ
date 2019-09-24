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


//re edit these to only include properties related to projected season and prjected game if they are similar.
//make them all optional except for player ID, name and positon
struct Player: Codable {
    var PlayerID: Int
    var Team: String?
    var Season: Int?
    var Name: String?
    var Position: String?
    var ByeWeek: Int?
    var PassingAttempts: Int?
    var PassingCompletions: Int?
    var PassingYards: Int?
    var PassingCompletionPercentage: Int?
    var PassingYardsPerAttempt: Int?
    var PassingYardsperCompletion:Int?
    var PassingTouchdowns: Int?
    var PassingInterceptions: Int?
    var PassingRating: Int?
    var PassingLong: Int?
    var RushingAttempts: Double?
    var RushingYards: Double?
    var RushingYardsPerAttempt: Double?
    var RushingTouchdowns: Int?
    var RushingLong: Int?
    var ReceivingTargets: Double?
    var Receptions: Double?
    var ReceivingYards: Double?
    var ReceivingYardsPerReception: Double?
    var ReceivingTouchdowns: Double?
    var ReceivingLong: Double?
    var Fumbles: Double?
    var FumblesLost: Double?
    var FantasyPoints: Double?
    var PuntReturns: Double?
    var PuntReturnYards: Double?
    var PuntReturnYardsPerAttempt: Double?
    var PuntReturnTouchdowns: Double?
    var PuntReturnLong: Double?
    var KickReturns: Double?
    var KickReturnYards: Double??
    var KickReturnYardsPerAttempt: Double?
    var KickReturnTouchdowns: Double?
    var FieldGoalsMade40to49: Double?
    var FieldGoalsMade50Plus: Double?
  }
struct Defense: Codable {
    var Season: Int
    var Week: Int
    var Team: String
    var Opponent: String
    var PointsAllowed: Int
    var TouchdownsScored: Int
    var SoloTackles: Int
    var AssistedTackles: Int
    var Sacks: Int
    var SackYards: Int
    var PassesDefended: Int
    var FumblesForced: Int
    var FumblesRecovered: Int
    var FumbleReturnYards: Int
    var FumbleReturnTouchdowns: Int
    var Interceptions: Int
    var InterceptionReturnYards: Int
    var InterceptionReturnTouchdowns: Int
    var Safeties: Int
    var FantasyPointsAllowed: Int
    var QuarterbackFantasyPointsAllowed: Int
    var RunningbackFantasyPointsAllowed: Int
    var WideReceiverFantasyPointsAllowed: Int
    var TightEndFantasyPointsAllowed: Int
    var KickerFantasyPointsAllowed: Int
    var BlockedKickReturnYards: Int
    var FieldGoalReturnYards: Int
    var QuarterbackHits: Int
    var TacklesForLoss: Int
    var DefensiveTouchdowns: Int
    var SpecialTeamsTouchdowns: Int
    var FantasyPoints: Int
    var Stadium: String
    var ThirdDownAttempts: Int
    var ThirdDownConversions: Int
    var FourthDownAttempts: Int
    var FourthDownConversions: Int
}

struct AllPlayers: Codable {
    var PlayerID: Int
    var Name: String
    var Team: String
    var position: String
    var ByeWeek: Int
}
