//
//  Cleric.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/23/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

enum ChannelEnergy: String {
    case Positive = "Positive (Cure)", Negative = "Negative (Inflict)"
}

enum Diety: String {
    case God
}

class Cleric: ClassObject, Spellcaster {
    
    var firstDomain: DomainObject
    var secondDomain: DomainObject
    var channelEnergyType: ChannelEnergy
    var diety: Diety
    var numberOfSpellsPerLevel = [Int : Int]()
    
    init(domain1: DomainObject, domain2: DomainObject) {
        firstDomain = domain1
        secondDomain = domain2
        self.availableSpells = [SpellReferenceName]()
        
        //Placeholders
        diety = Diety.God
        channelEnergyType = ChannelEnergy.Positive
    }
    
    // MARK: Spellcaster Protocol
    var availableSpells: [SpellReferenceName]
    
    func loadAvailableSpells() {
        let allClericSpells = DBManager.fetchClassSpellsFromDatabase("Cleric")
        for spell in allClericSpells {
            availableSpells.append(spell)
        }
        for spell in availableDomainSpells {
            availableSpells.append(spell)
        }
    }
}

extension Cleric {
    var availableDomainSpells: [SpellReferenceName] {
        get {
            var domainSpells = [SpellReferenceName]()
            domainSpells.appendContentsOf(firstDomain.domainSpells)
            domainSpells.appendContentsOf(secondDomain.domainSpells)
            
            return domainSpells
        }
    }
}

class DomainObject {
    
    var name = ""
    var description = ""
    var specialAbility1 = SpecialAbilityObject()
    var specialAbility2 = SpecialAbilityObject()
    
    var domainSpells = [SpellReferenceName]()
}
