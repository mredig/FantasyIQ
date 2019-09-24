//
//  Player.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

struct Player: Codable {
    var PlayerID: Int
    var Team: String
    var Season: Int
    var Name: String
    var Position: String
    var PassingAttempts: Int
    var PassingCompletions: Int
    var PassingYards: Int
    var PassingCompletionPercentage: Int
    var PassingYardsPerAttempt: Int
    var PassingYardsperCompletion:Int
    var PassingTouchdowns: Int
    var PassingInterceptions: Int
    var PassingRating: Int
    var PassingLong: Int
    var RushingAttempts: Int
    var RushingYards: Int
    var RushingYardsPerAttempt: Int
    var RushingTouchdowns: Int
    var RushingLong: Int
    var ReceivingTargets: Int
    var Receptions: Int
    var ReceivingYards: Int
    var ReceivingYardsPerReception: Int
    var ReceivingTouchdowns: Int
    var ReceivingLong: Int
    var Fumbles: Int
    var FumblesLost: Int
    var PuntReturns: Int
    var PuntReturnYards: Int
    var PuntReturnYardsPerAttempt: Int
    var PuntReturnTouchdowns: Int
    var PuntReturnLong: Int
    var KickReturns: Int
    var KickReturnYards: Int
    var KickReturnYardsPerAttempt: Int
    var KickReturnTouchdowns: Int
    var FieldGoalsMade40to49: Int
    var FieldGoalsMade50Plus: Int
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
