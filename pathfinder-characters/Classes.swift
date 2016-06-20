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

/*
class Cleric: CharacterClass {
    
    let name = "Cleric"
    let startingGold = 140
    let hitDie = 8
    let skillRanksPerLevel = 2 // + INT Modifier
    let classSkills = ["Appraise", "Craft", "Diplomacy", "Heal", "Knowlege (Arcana)", "Knowlege (History)", "Knowlege (Nobility)", "Knowlege (Planes)", "Knowlege (Religion)", "Linguistics", "Profession", "Sense Motive", "Spellcraft"]
    var level: Int
    var savingThrows: [String : Int]? {
        get {
            return ["Fort" : 2 + Int(floor(Double(level / 2))),
             "Ref" : 0 + Int(floor(Double(level / 3))),
             "Will" : 2 + Int(floor(Double(level / 2))),]
        }
    }
    
    init(level: Int) {
        self.level = level
    }
    
    // CLASS-SPECIFIC
    
    
}

*/