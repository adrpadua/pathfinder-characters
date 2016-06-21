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
    
    convenience init(name: String, ability: String) {
        self.init()
        self.name = name
        self.keyAbility = ability
    }
    
    // OTHER STUFF
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
        return DBManager.getSkillObject(self.name).short_description
    }
    
    func addRank() {
        ranks += 1
        
        if self.isClassSkill()  && ranks > 0 {
            classSkillBonus = 3
        }
    }
    
    func isClassSkill() -> Bool {
        let classObj = parentPlayerCharacter.classObject
        
        
        return (classObj!.classSkills[self.name])!
        
//        for classSkill in (classObj!.classSkills) {
//            print("Testing \(classSkill) against \(self.name)")
//            if classSkill == self.name {
//                print("\(self.name) is a class Skill")
//                return true
//            }
//            print("\(self.name) is not a class Skill")
//        }
//        return false
    }
}