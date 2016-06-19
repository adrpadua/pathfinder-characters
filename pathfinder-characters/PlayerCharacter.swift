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
        dynamic var pc_hitPoints = 1
        dynamic var pc_maxHitPoints = 1
    
        // Saving Throws
        dynamic var pc_fortitude = 0
        dynamic var pc_reflex = 0
        dynamic var pc_willpower = 0
    
    // MARK: To-one relationships
    dynamic var pc_abilityScores: AbilityScoreList?
    dynamic var pc_skills: SkillList?
    dynamic var pc_feats: FeatsList?
    
    // MARK: Reference Objects
    var classObject: CharacterClass? {
        get {
            guard pc_class != "" else {
                return nil
            }
            return classObjFromString(pc_class, level: pc_level)
        }
    }
    
    
    
    
    
    // MARK: Setter functions
    func setName(newName: String) {
        try! realm!.write {
            self.pc_name = newName
        }
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
        setMaxHitPoints()
    }
    
    func setLevel(newLevel: Int) {
        try! realm!.write {
            self.pc_level = newLevel
        }
    }
    
    func setAbilityScores(newScores: [Int]) {
        try! realm!.write {
            pc_abilityScores = AbilityScoreList()
            pc_abilityScores!.generateAbilityScores(newScores)
        }
    }
    
    func setBaseSkills() {
        
        try! realm!.write {
            pc_skills = SkillList()
            pc_skills!.generateBaseSkillList()
        }
    }
    
    func setEmptyFeatsList() {
        
        try! realm!.write {
            pc_feats = FeatsList()
        }
    }
    
    func setMaxHitPoints() {
        if pc_level == 1 && pc_class != "" {
            try! realm!.write {
                pc_maxHitPoints = classObject!.hitDie
            }
            setHitPoints(pc_maxHitPoints)
        }
    }
    
    func setHitPoints(newHP: Int) {
        try! realm!.write {
            pc_hitPoints = newHP
        }
    }
    
    func setSavingThrows() {
        
        guard pc_abilityScores != nil else {
            print("Error, no ability scores")
            return
        }
        
        try! realm!.write {
            
            let conMod = self.CON.modifier
            let dexMod = self.DEX.modifier
            let wisMod = self.WIS.modifier
            
            guard classObject != nil else {
                print("Error in setSavingThrows()")
                return
            }
            pc_fortitude = conMod + classObject!.savingThrows!["Fort"]!
            pc_reflex = dexMod + classObject!.savingThrows!["Ref"]!
            pc_willpower = wisMod + classObject!.savingThrows!["Will"]!
        }
    }
    
    
    
    // HELPER FUNCTIONS
    func addFeat(featName: String) {
        try! realm!.write {
            pc_feats!.addFeat(featName)
        }
    }
    
    func modifySkill(skillToModify: String, byAmount: Int) {
        
        let skillObj = pc_skills?.getElementFromName(skillToModify)
        try! realm!.write {
            pc_skills!.modifySkill(skillToModify, amountToModify: byAmount, isClassSkill: skillObj!.isClassSkill())
            pc_skills!.numRanks += byAmount
        }
    }
    
}


extension PlayerCharacter {
    var STR: AbilityScore {
        return pc_abilityScores!.getElementFromName("STR")
    }
    var DEX: AbilityScore {
        return pc_abilityScores!.getElementFromName("DEX")
    }
    var CON: AbilityScore {
        return pc_abilityScores!.getElementFromName("CON")
    }
    var INT: AbilityScore {
        return pc_abilityScores!.getElementFromName("INT")
    }
    var WIS: AbilityScore {
        return pc_abilityScores!.getElementFromName("WIS")
    }
    var CHA: AbilityScore {
        return pc_abilityScores!.getElementFromName("CHA")
    }
}





