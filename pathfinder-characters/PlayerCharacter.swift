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
    private dynamic var pc_name = ""
    private dynamic var pc_race = ""
    private dynamic var pc_class = ""
    private dynamic var pc_level = 1
    private dynamic var pc_hitPoints = 1
    private dynamic var pc_maxHitPoints = 1
    
    // MARK: To-one relationships
    let pc_skills = List<Skill>()
    
    dynamic var pc_abilityScores: AbilityScoreList?
    dynamic var pc_feats: FeatsList?
    
    // MARK: Reference Objects
    var classObject: CharacterClass? {
        get {
            guard pc_class != "" else {
                return nil
            }
            return DBManager.getClassObject(pc_class, level: pc_level)
        }
    }
    
    // MARK: Computed Properties
    var pc_savingThrows: [String : Int] {
    
        var pc_savingThrows = [String : Int]()
        
        let conMod = self.CON.modifier
        let dexMod = self.DEX.modifier
        let wisMod = self.WIS.modifier
    
        guard classObject != nil else {
            print("Error in setSavingThrows()")
            return [String : Int]()
        }
        
        pc_savingThrows["Fortitude"] = conMod + classObject!.savingThrows!["Fort"]!
        pc_savingThrows["Reflex"] = dexMod + classObject!.savingThrows!["Ref"]!
        pc_savingThrows["Willpower"] = wisMod + classObject!.savingThrows!["Will"]!
        
        return pc_savingThrows
    }
    
    
    
    
    
    
    // MARK: Getter functions
    var name: String {
        return pc_name
    }
    
    
    // MARK: Setter functions
    func setName(name: String) {
        try! realm!.write {
            self.pc_name = name
        }
    }
    
    func setRace(named: String) {
        try! realm!.write {
            self.pc_race = named
        }
    }
    
    func setClass(named: String) {
        try! realm!.write {
            self.pc_class = named
        }
        setMaxHitPoints()
    }
    
    func setLevel(value: Int) {
        try! realm!.write {
            self.pc_level = value
        }
    }
    
    func setAbilityScores(values: [Int]) {
        try! realm!.write {
            pc_abilityScores = AbilityScoreList()
            pc_abilityScores!.generateAbilityScores(values)
        }
    }
    
    func setBaseSkills() {
        
        let skillNames = ["Acrobatics", "Appraise", "Bluff", "Climb", "Craft", "Diplomacy", "DisableDevice", "Disguise", "EscapeArtist", "Fly", "HandleAnimal", "Heal", "Intimidate", "Knowledge (Arcana)", "Knowledge (Dungeoneering)", "Knowledge (Engineering)", "Knowledge (History)", "Knowledge (Geography)", "Knowledge (Local)", "Knowledge (Nature)", "Knowledge (Nobility)", "Knowledge (Planes)", "Knowledge (Religion)", "Linguistics", "Perception", "Perform", "Profession", "Ride", "Sense Motive", "Sleight Of Hand", "Spellcraft", "Stealth", "Survival", "Swim", "Use Magic Device"]
        
        try! realm!.write {
            for index in 1...35 {
                let skill = DBManager.getSkillObject(skillNames[index - 1])
                pc_skills.append(skill)
            }
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
    
    
    
    
    
    // HELPER FUNCTIONS
    func addFeat(featName: String) {
        try! realm!.write {
            pc_feats!.addFeat(featName)
        }
    }
    
    func modifySkill(name: String, byAmount: Int) {
        
        let skillObj = pc_skills.getItemNamed(name)
        
        try! realm!.write {
            skillObj.addRanks(byAmount)
        }
    }
    

}


// MARK: Extensions
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
    var Fortitude: Int {
        return pc_savingThrows["Fortitude"]!
    }
    var Reflex: Int {
        return pc_savingThrows["Reflex"]!
    }
    var Willpower: Int {
        return pc_savingThrows["Willpower"]!
    }
}

extension List where T:Skill {
    func getItemNamed(name: String) -> T {
        
        let object = self.filter("name == %@", "\(name)")[0]
        
        return object
    }
}




