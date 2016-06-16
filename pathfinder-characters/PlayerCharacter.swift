//
//  PlayerCharacter.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/6/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
import Darwin

let realm = Manager.instance.realm

class PlayerCharacter: Object {
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
    
    // Properties
    dynamic var pc_name = ""
    dynamic var pc_race = ""
    dynamic var pc_class = ""
    dynamic var pc_level = 1
    
    // MARK: To-one relationships
    dynamic var pc_abilityScores: AbilityScoreList?
    dynamic var pc_skills: SkillList?
    dynamic var pc_feats: FeatsList?
    
    // MARK: Setter functions
    func setName(newName: String) {
        try! realm!.write {
            self.pc_race = newName
        }
        self.pc_name = newName
    }
    
    func setRace(newRace: String) {
        try! realm!.write {
            self.pc_race = newRace
        }
    }
    
    func setClass(newClass: String) {
        try! realm!.write {
            self.pc_class = newClass
        }
    }
    
    func setLevel(newLevel: Int) {
        try! realm!.write {
            self.pc_level = newLevel
        }
    }
    
    func setAbilityScores(newScores: [Int]) {
        try! realm!.write {
            pc_abilityScores = AbilityScoreList()
            pc_abilityScores!.parentPlayerCharacter = self
            pc_abilityScores!.generateAbilityScores(newScores)
        }
    }
    
    func setBaseSkills() {
        
        try! realm!.write {
            pc_skills = SkillList()
            pc_skills!.parentPlayerCharacter = self
            pc_skills!.generateBaseSkillList()
        }
    }
    
    func setEmptyFeatsList() {
        
        try! realm!.write {
            pc_feats = FeatsList()
            pc_feats!.parentPlayerCharacter = self
        }
    }
    
    
    
    
    
    
    
    
    
    
    // HELPER FUNCTIONS
    func addFeat(featName: String) {
        
        try! realm!.write {
            pc_feats!.addFeat(featName)
        }
    }
    
    func modifySkill(skillToModify: String, byAmount: Int) {
        
        try! realm!.write {
            
            pc_skills!.modifySkill(skillToModify, amountToModify: byAmount, isClassSkill: isClassSkill(skillToModify))
            pc_skills!.numRanks += byAmount
        }
    }
    
    func isClassSkill(skillToCheck: String) -> Bool {
        
        var classesArray: [String]
        
        let skill = pc_skills!.findSkillWithName(skillToCheck).skillsEnum()
        classesArray = skill!.classesFavoringSkill()
        
        for className in classesArray {
            if pc_class == className {
                return true
            }
        }
        return false
    }
}





