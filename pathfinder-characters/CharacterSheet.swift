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


class CharacterSheet: Object {
    
    ///// Saved to Realm ///////////////////////////////
    private dynamic var _name = ""
    private dynamic var _raceName = ""
    private dynamic var _className = ""
    private dynamic var _level = 1
    private dynamic var _currentHitPoints = 1
    private dynamic var _maxHitPoints = 1
    
    let _skills = List<Skill>()
    let _abilityScores = List<AbilityScore>()
    let _feats = List<Feat>()
    let _inventory = List<EquipmentReferenceName>()
    ////////////////////////////////////////////////////
    
    
    // MODIFYING FUNCTIONS
    func adjustHP(byAmount: Int) {
        try! realm!.write {
            _currentHitPoints += byAmount
        }
        
    }
    
    func addFeat(featName: String) {
        let featObj = DBManager.fetchFeatObjectFromDatabase(featName)
        
        try! realm!.write {
            _feats.append(featObj)
        }
    }
    
    func addSkillRankTo(name: String) {
        let skillObj = _skills.getItemNamed(name)
        
        try! realm!.write {
            skillObj.addRank()
        }
    }
    
    func addEquipmentToInventory(name: String) {
        
        let equipmentObj = DBManager.fetchEquipmentObjectFromDatabase(name)
        let equipmentReferenceName = EquipmentReferenceName(name: equipmentObj.name)
        
        try! realm!.write {
            _inventory.append(equipmentReferenceName)
        }
    }
    
    
    
    
    
    
    
    
    
    // MARK: Setter functions
    func setName(name: String) {
        try! realm!.write {
            self._name = name
        }
    }
    
    func setRaceName(name: String) {
        try! realm!.write {
            self._raceName = name
        }
    }
    
    func setClassName(name: String) {
        try! realm!.write {
            self._className = name
        }
        setMaxHitPoints()
    }
    
    func setLevel(value: Int) {
        try! realm!.write {
            self._level = value
        }
    }
    
    func setAbilityScores(values: [Int]) {
        if values.count == 6 {
            
            let names = ["STR", "DEX", "CON", "INT", "WIS", "CHA"]
            
            try! realm!.write {
                
                for index in 1...6 {
                    let abilityObj = AbilityScore()
                    
                    let abilityName = names[index - 1]
                    let raceBonus = raceObj.abilityScoreRacialBonuses[abilityName]
                    let abilityValue = values[index - 1] + raceBonus!
                    
                    abilityObj.name = abilityName
                    abilityObj.value = abilityValue
                    
                    _abilityScores.append(abilityObj)
                }
            }
            
        } else {
            print("Error setting scores")
        }
        
    }
    
    func setBaseSkills() {
        
        try! realm!.write {
            for index in 1...skillNames.count {
                let skill = DBManager.fetchSkillObjectFromDatabase(skillNames[index - 1])
                _skills.append(skill)
            }
        }
    }
    
    func setMaxHitPoints() {
        if _level == 1 && _className != "" {
            try! realm!.write {
                _maxHitPoints = classObj.hitDie
            }
            setHitPoints(_maxHitPoints)
        }
    }
    
    func setHitPoints(newHP: Int) {
        try! realm!.write {
            _currentHitPoints = newHP
        }
    }
    
    
    
    
    
}

extension CharacterSheet {
    var STR: AbilityScore {
        return _abilityScores.getItemNamed("STR")
    }
    var DEX: AbilityScore {
        return _abilityScores.getItemNamed("DEX")
    }
    var CON: AbilityScore {
        return _abilityScores.getItemNamed("CON")
    }
    var INT: AbilityScore {
        return _abilityScores.getItemNamed("INT")
    }
    var WIS: AbilityScore {
        return _abilityScores.getItemNamed("WIS")
    }
    var CHA: AbilityScore {
        return _abilityScores.getItemNamed("CHA")
    }
    var savingThrows: [String : Int] {
        
        var _savingThrows = [String : Int]()
        
        let conMod = self.CON.modifier
        let dexMod = self.DEX.modifier
        let wisMod = self.WIS.modifier
        
        guard _className.isNotEmpty else {
            print("Error in savingThrows()")
            return [String : Int]()
        }
        
        _savingThrows["Fortitude"] = conMod + classObj.savingThrows!["Fort"]!
        _savingThrows["Reflex"] = dexMod + classObj.savingThrows!["Ref"]!
        _savingThrows["Willpower"] = wisMod + classObj.savingThrows!["Will"]!
        
        return _savingThrows
    }
    var Fortitude: Int {
        return savingThrows["Fortitude"]!
    }
    var Reflex: Int {
        return savingThrows["Reflex"]!
    }
    var Willpower: Int {
        return savingThrows["Willpower"]!
    }
    var name: String {
        get {
            return _name
        }
    }
    var classObj: CharacterClass {
        get {
            return DBManager.fetchClassObjectFromDatabase(_className, level: _level)
        }
    }
    var raceObj: Race {
        get {
            return DBManager.fetchRaceObjectFromDatabase(_raceName)
        }
    }
    var level: Int {
        get {
            return _level
        }
    }
    var currentHP: Int {
        get {
            return _currentHitPoints
        }
    }
    var maxHP: Int {
        get {
            return _maxHitPoints
        }
    }
}

