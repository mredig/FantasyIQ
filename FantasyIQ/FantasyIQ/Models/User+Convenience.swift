//
//  User+Convenience.swift
//  FantasyIQ
//
//  Created by Luqmaan Khan on 9/27/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import CoreData

extension Player {
    
    convenience init(name: String,
                     fantasyPoints: Double,
                     playerID: Int16,
                     position: String,
                     season: Int16,
                     identifier: String = UUID().uuidString,
                     team: String,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.fantasyPoints = fantasyPoints
        self.position = position
        self.season = season
        self.identifier = identifier
        self.team = team
        self.playerID = playerID
    }
}

extension PlayerGame {
    convenience init(name: String,
                     fantasyPoints: Double,
                     playerID: Int16,
                     position: String,
                     activated: Int16,
                     identifier: String = UUID().uuidString,
                     team: String,
                     opponent: String,
                     number: Int16,
                     homeAway:String,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.fantasyPoints = fantasyPoints
        self.position = position
        self.activated = activated
        self.identifier = identifier
        self.team = team
        self.opponent = opponent
        self.number = number
        self.homeAway = homeAway
        self.playerID = playerID
    }
    
    
}
