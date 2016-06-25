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
    
    init(domain1: DomainObject, domain2: DomainObject) {
        firstDomain = domain1
        secondDomain = domain2
    }
    
}

extension Cleric {
    var availableDomainSpells: [Int : [SpellReferenceName]] {
        get {
            var domainSpells = [Int : [SpellReferenceName]]()
            
            for index in 1...9 {
                domainSpells[index]?.append(self.firstDomain.domainSpells[index]!)
                domainSpells[index]?.append(self.secondDomain.domainSpells[index]!)
            }
            
            return domainSpells
        }
    }
}

class DomainObject {
    
    var name = ""
    var specialAbility1 = SpecialAbilityObject()
    var specialAbility2 = SpecialAbilityObject()
    
    var domainSpells = [Int : SpellReferenceName]()
}
