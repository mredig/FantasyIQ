//
//  FantasyIQTests.swift
//  FantasyIQTests
//
//  Created by Luqmaan Khan on 9/23/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import XCTest
import Foundation
@testable import FantasyIQ

class FantasyIQTests: XCTestCase {

let fantasyIqController = FantasyIQController()
    
func testFetchAllFantasyPlayers() {
    
    let fetchPlayersExpectation = expectation(description: "didFinishFetch")
    fantasyIqController.fetchAllPlayers { (_, _) in
        fetchPlayersExpectation.fulfill()
    }
    wait(for: [fetchPlayersExpectation], timeout: 10)
    
    XCTAssert(fantasyIqController.allFantasyPlayers.count > 0)
}
    
    func testProjectedSeasonStats() {
        
        let fetchPlayersExpectation = expectation(description: "didFinishFetch")
        fantasyIqController.fetchAllPlayers { (_, _) in
            fetchPlayersExpectation.fulfill()
        }
        wait(for: [fetchPlayersExpectation], timeout: 10)
        
        XCTAssert(fantasyIqController.allFantasyPlayers.count > 0)
        
        
        let fetchProjectedSeasonStats = expectation(description: "didFinishFetch")
        fantasyIqController.fetchProjectedSeasonStats(playerName: "DeAndre Hopkins") { (_, _) in
            fetchProjectedSeasonStats.fulfill()
        }
        wait(for: [fetchProjectedSeasonStats], timeout: 60)
        XCTAssertNotNil(fantasyIqController.projectedSeasonStats)
    }

}
