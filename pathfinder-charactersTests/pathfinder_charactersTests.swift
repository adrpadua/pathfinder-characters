//
//  pathfinder_charactersTests.swift
//  pathfinder-charactersTests
//
//  Created by Adrian Padua on 6/22/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import XCTest
@testable import Pods_pathfinder_characters
@testable import pathfinder_characters

class pathfinder_charactersTests: XCTestCase {
    
    var character = PlayerCharacter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Manager.instance.deActivateCurrentCharacter()
        Manager.instance.createNewCharacter()
        character = Manager.instance.active_pc!
        
        character.setName("Largolass Largleaf")
        character.setRaceName("Elf")
        character.setClassName("Cleric")
        let scores = [15, 13, 12, 8, 9, 10]
        character.setAbilityScores(scores)
        character.setBaseSkills()
        character.addSkillRankTo("Climb")
        character.addSkillRankTo("Perception")
        character.addSkillRankTo("Knowledge (Arcana)")
        character.addFeat("Alignment Channel")
        character.addFeat("Penetrating Strike")
        character.setMaxHitPoints()
        character.addEquipmentToInventory("Dagger")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActivePC() {
        XCTAssert(Manager.instance.active_pc != nil)
    }
    
}
