//
//  Team.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/26/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import Firebase

//class Team: Codable, Equatable {
//    let identifier: String
//    var team: [SeasonProjection]?
//
//    init(identifier: String = UUID().uuidString, team: [SeasonProjection] = []) {
//        self.identifier = identifier
//        self.team = team
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let identifier = try container.decode(String.self, forKey: .identifier)
//        if let players = try container.decodeIfPresent([String: SeasonProjection].self, forKey: .team) {
//            self.team = Array(players.values)
//        } else {
//            self.team = []
//        }
//        self.identifier = identifier
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: AnyObject],
//            let identifier = value["identifier"] as? String else {
//                return nil
//        }
//        let team = value["team"] as? [Any]
//        self.identifier = identifier
//        self.team = team as? [SeasonProjection]
//    }
//
//    static func ==(lhs: Team, rhs: Team) -> Bool {
//           return
//               lhs.identifier == rhs.identifier &&
//               lhs.team == rhs.team
//       }
//
//    func toAnyObject() -> Any {
//        return [
//            "identifier": identifier,
//            "team": team ?? []
//        ]
//    }
//}
