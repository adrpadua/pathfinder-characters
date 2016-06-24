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
    var level = 0
    var skillRanksPerLevel = 0
    var classSkills = [String : Bool]()
    
    var savingThrows: [String : Int]? {
        get {
            return ["Fort" : 2 + Int(floor(Double(level / 2))),
                    "Ref" : 0 + Int(floor(Double(level / 3))),
                    "Will" : 2 + Int(floor(Double(level / 2))),]
        }
    }
}

class Cleric: ClassObject {
    
    var firstDomain: DomainObject
    var secondDomain: DomainObject
    var numberOfSpellsPerLevel = [String : Int]()
    
    override init() {
        firstDomain = DomainObject()
        secondDomain = DomainObject()
    }
}

class DomainObject {
    
    var name = ""
    var specialAbility1 = SpecialAbilityObject()
    var specialAbility2 = SpecialAbilityObject()
    
    var domainSpells = List<SpellReferenceName>()
}

class SpecialAbilityObject {
    
    var name = ""
    var type = ""
    var description = ""
}
