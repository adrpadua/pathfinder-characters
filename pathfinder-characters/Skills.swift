//
//  CharacterSkills.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class Skill: Object {
    
    
    // REALM-PERSISTED ITEMS
    let partOfList = LinkingObjects(fromType: SkillList.self, property: "list")
    dynamic var name = ""
    dynamic var keyAbility = ""
    dynamic var classSkillBonus = 0
    dynamic var ranks = 0
    
    convenience init(name: String, ability: String) {
        self.init()
        self.name = name
        self.keyAbility = ability
    }
    
    // OTHER STUFF
    var parentPlayerCharacter: PlayerCharacter {
        get {
            return (partOfList.first!.parentPlayerCharacter)
        }
    }
    
    var abilityModifierBonus: Int {
        get {
            return parentPlayerCharacter.pc_abilityScores!.getElementFromName(keyAbility).modifier
        }
    }
    
    var total: Int {
        get {
            return classSkillBonus + ranks + abilityModifierBonus
        }
    }
    
    var short_description: String {
        return DBManager.getSkillObject(self.name).short_description
    }
    
    func addRanks(num: Int) {
        ranks += num
    }
    
    func isClassSkill() -> Bool {
        let classObj = parentPlayerCharacter.classObject
        for classSkill in (classObj!.classSkills) {
            if classSkill == self.name {
                return true
            }
        }
        return false
    }
}