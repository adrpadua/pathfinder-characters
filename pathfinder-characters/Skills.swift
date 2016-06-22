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
    
    let partOfCharacter = LinkingObjects(fromType: PlayerCharacter.self, property: "pc_skills")
    
    dynamic var name = ""
    dynamic var keyAbility = ""
    dynamic var classSkillBonus = 0
    dynamic var ranks = 0
    
    
    var parentPlayerCharacter: PlayerCharacter {
        get {
            return (partOfCharacter.first!)
        }
    }
    
    var abilityModifierBonus: Int {
        get {
            return parentPlayerCharacter.pc_abilityScores.getItemNamed(keyAbility).modifier
        }
    }
    
    var total: Int {
        get {
            return classSkillBonus + ranks + abilityModifierBonus
        }
    }
    
    var short_description: String {
        return DBManager.fetchSkillObjectFromDatabase(self.name).short_description
    }
    
    func addRank() {
        ranks += 1
        
        if self.isClassSkill()  && ranks > 0 {
            classSkillBonus = 3
        }
    }
    
    func isClassSkill() -> Bool {
        let classObj = parentPlayerCharacter.pc_class
        return (classObj!.classSkills[self.name])!
    }
}