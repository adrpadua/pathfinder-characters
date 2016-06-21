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
    
    // Unindexed properties
    var classObject: CharacterClass? {
        get {
            guard pc_class != "" else {
                return nil
            }
            return DBManager.getClassObject(pc_class, level: pc_level)
        }
    }
    
    var raceObject: Race? {
        get {
            guard pc_race != "" else {
                return nil
            }
            return DBManager.getRaceObject(pc_race)
        }
    }
    
    // MARK: To-one relationships
    let pc_skills = List<Skill>()
    let pc_abilityScores = List<AbilityScore>()
    let pc_feats = List<Feat>()
    let pc_inventory = List<Equipment>()
    
    
    // MARK: Computed Properties
    var pc_savingThrows: [String : Int] {
    
        var pc_savingThrows = [String : Int]()
        
        let conMod = self.CON.modifier
        let dexMod = self.DEX.modifier
        let wisMod = self.WIS.modifier
    
        guard classObject != nil else {
            print("Error in savingThrows()")
            return [String : Int]()
        }
        
        pc_savingThrows["Fortitude"] = conMod + classObject!.savingThrows!["Fort"]!
        pc_savingThrows["Reflex"] = dexMod + classObject!.savingThrows!["Ref"]!
        pc_savingThrows["Willpower"] = wisMod + classObject!.savingThrows!["Will"]!
        
        return pc_savingThrows
    }
    
    
    // MARK: Getter functions
    var name: String {
        get {
            return pc_name
        }
    }
    var race: String {
        get {
            return pc_name
        }
    }
    var charClass: String {
        get {
            return pc_name
        }
    }
    var level: Int {
        get {
            return pc_level
        }
    }
    var currentHP: Int {
        get {
            return pc_hitPoints
        }
    }
    var maxHP: Int {
        get {
            return pc_maxHitPoints
        }
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
        if values.count == 6 {
            
            let names = ["STR", "DEX", "CON", "INT", "WIS", "CHA"]
            
            try! realm!.write {
                
                for index in 1...6 {
                    // TODO: Race Bonus
                    let abilityName = names[index - 1]
                    print(raceObject!)
                    let raceBonus = raceObject!.abilityScoreBonuses[abilityName]
                    print(raceBonus!)
                    let abilityValue = values[index - 1] + raceBonus!
                    let abilityObj = AbilityScore(name: abilityName, value: abilityValue)
                    pc_abilityScores.append(abilityObj)
                }
            }
            
        } else {
            print("Error setting scores")
        }
        
    }
    
    func setBaseSkills() {
        
        let skillNames = ["Acrobatics"
            , "Appraise"
            , "Bluff"
            , "Climb"
            , "Craft"
            , "Diplomacy"
            , "Disable Device"
            , "Disguise"
            , "Escape Artist"
            , "Fly"
            , "Handle Animal"
            , "Heal"
            , "Intimidate"
            , "Knowledge (Arcana)"
            , "Knowledge (Dungeoneering)"
            , "Knowledge (Engineering)"
            , "Knowledge (History)"
            , "Knowledge (Geography)"
            , "Knowledge (Local)"
            , "Knowledge (Nature)"
            , "Knowledge (Nobility)"
            , "Knowledge (Planes)"
            , "Knowledge (Religion)"
            , "Linguistics"
            , "Perception"
            , "Perform"
            , "Profession"
            , "Ride"
            , "Sense Motive"
            , "Sleight of Hand"
            , "Spellcraft"
            , "Stealth"
            , "Survival"
            , "Swim"
            , "Use Magic Device"]
        
        try! realm!.write {
            for index in 1...skillNames.count {
                let skill = DBManager.getSkillObject(skillNames[index - 1])
                pc_skills.append(skill)
            }
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
    
    
    
    
    
    
    
    
    
    
    // MODIFYING FUNCTIONS
    func addFeat(featName: String) {
        try! realm!.write {
            let feat = DBManager.getFeatObject(featName)
            pc_feats.append(feat)
        }
    }
    
    func addSkillRankTo(name: String) {
        
        let skillObj = pc_skills.getItemNamed(name)
        
        try! realm!.write {
            skillObj.addRank()
        }
    }
}



// MARK: Extensions
extension PlayerCharacter {
    var STR: AbilityScore {
        return pc_abilityScores.getItemNamed("STR")
    }
    var DEX: AbilityScore {
        return pc_abilityScores.getItemNamed("DEX")
    }
    var CON: AbilityScore {
        return pc_abilityScores.getItemNamed("CON")
    }
    var INT: AbilityScore {
        return pc_abilityScores.getItemNamed("INT")
    }
    var WIS: AbilityScore {
        return pc_abilityScores.getItemNamed("WIS")
    }
    var CHA: AbilityScore {
        return pc_abilityScores.getItemNamed("CHA")
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

extension List {
    func getItemNamed(name: String) -> T {
        
        let object = self.filter("name == %@", "\(name)")[0]
        
        return object
    }
}




