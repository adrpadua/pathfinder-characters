//
//  Classes.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import Darwin


class CharacterClass {
    
    var name: String
    var startingGold: Int
    var hitDie: Int
    var level: Int
    var skillRanksPerLevel: Int
    var classSkills: [String]
    
    init () {
        self.name = ""
        self.startingGold = 0
        self.hitDie = 0
        self.level = 0
        self.skillRanksPerLevel = 0
        self.classSkills = [""]
    }
    
    init(name: String, gold: Int, hitDie: Int, level: Int, skillRanks: Int, classSkills: [String]) {
        self.name = name
        self.startingGold = gold
        self.hitDie = hitDie
        self.level = level
        self.skillRanksPerLevel = skillRanks
        self.classSkills = classSkills
    }
    
    var savingThrows: [String : Int]? {
        get {
            return ["Fort" : 2 + Int(floor(Double(level / 2))),
                    "Ref" : 0 + Int(floor(Double(level / 3))),
                    "Will" : 2 + Int(floor(Double(level / 2))),]
        }
    }
}