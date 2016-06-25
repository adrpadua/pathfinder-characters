//
//  Cleric.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/23/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

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
