//
//  Classes.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import Darwin
import RealmSwift

class ClassObject {
    
    var name = ""
    var startingGold = 0
    var hitDie = 0
    var level = 1
    var skillRanksPerLevel = 0
    var classSkills = [String : Bool]()
    var baseAttackBonus = [Int]()
    
    
    var specialAbilities: [SpecialAbilityObject] {
        get {
            return DBManager.fetchSpecialAbilityArrayFromDatabase(self.name, level: self.level)
        }
    }
    
    var savingThrows: [String : Int]? {
        get {
            return ["Fort" : 2 + Int(floor(Double(level / 2))),
                    "Ref" : 0 + Int(floor(Double(level / 3))),
                    "Will" : 2 + Int(floor(Double(level / 2))),]
        }
    }
    
}
