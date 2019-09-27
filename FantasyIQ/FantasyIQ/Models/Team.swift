//
//  Team.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/26/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import Firebase

class Team: Codable, Equatable {
    let identifier: String?
    var players: [SeasonProjection]?

    init(identifier: String = UUID().uuidString, team: [SeasonProjection] = []) {
        self.identifier = identifier
        self.players = team
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let identifier = try container.decode(String.self, forKey: .identifier)
        if let players = try container.decodeIfPresent([String: SeasonProjection].self, forKey: .players) {
            self.players = Array(players.values)
        } else {
            self.players = []
        }
        self.identifier = identifier
    }

    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let identifier = value["identifier"] as? String,
            let team = value["team"] as? [String:Any] else {
                return nil
        }
        self.identifier = identifier
        let players = team.values.map {SeasonProjection(team: $0 as! [String : Any])}
        self.players = players as? [SeasonProjection]
    }
    

    static func ==(lhs: Team, rhs: Team) -> Bool {
           return
               lhs.identifier == rhs.identifier &&
               lhs.players == rhs.players
       }

    func toAnyObject() -> Any {
        return [
            "identifier": identifier,
            "players": players?.map {$0.toAnyObject()}
        ]
    }
}
