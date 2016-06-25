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
    
    ///// SAVED TO REALM ///////////////////////////////
    private dynamic var _name = ""
    private dynamic var _raceName = ""
    private dynamic var _className = ""
    private dynamic var _level = 1
    private dynamic var _currentHitPoints = 1
    private dynamic var _maxHitPoints = 1
    private dynamic var _alignment = ""
    
    let _abilityScores = List<AbilityScore>()
    
    let _skills = List<SkillReferenceName>()
    let _feats = List<FeatReferenceName>()
    let _inventory = List<EquipmentReferenceName>()
    let _spells = List<SpellReferenceName>()
    
    ///// NOT SAVED TO REALM ///////////////////////////
    override static func ignoredProperties() -> [String] {
        return ["_preparedSpells"]
    }
    let _preparedSpells = List<SpellReferenceName>()
    
    
    ///// MODIFYING FUNCTIONS //////////////////////////
    func adjustHP(byAmount: Int) {
        try! realm!.write {
            _currentHitPoints += byAmount
        }
    }
    func addFeat(name: String) {
        let featReferenceName = FeatReferenceName(name: name)
        
        try! realm!.write {
            _feats.append(featReferenceName)
        }
    }
    func addSpellToSpellList(name: String) {
        let spellReferenceName = SpellReferenceName(name: name)
        
        try! realm!.write {
            _spells.append(spellReferenceName)
        }
    }
    func addSkillRankTo(name: String) {
        let skillRef = _skills.getReferenceNamed(name)
        
        try! realm!.write {
            skillRef.ranks += 1
        }
    }
    func addEquipmentToInventory(name: String) {
        
        let equipmentReferenceName = EquipmentReferenceName(name: name)
        
        try! realm!.write {
            _inventory.append(equipmentReferenceName)
        }
    }
    
    ///// SETTER FUNCTIONS /////////////////////////////
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
    func setAlignment(alignment: String) {
        try! realm!.write {
            self._alignment = alignment
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
                let skillRefName = SkillReferenceName(name: skillNames[index - 1])
                
                _skills.append(skillRefName)
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
    // END CHARACTER SHEET
}







extension CharacterSheet {
    var STR: AbilityScore {
        return _abilityScores.getReferenceNamed("STR")
    }
    var DEX: AbilityScore {
        return _abilityScores.getReferenceNamed("DEX")
    }
    var CON: AbilityScore {
        return _abilityScores.getReferenceNamed("CON")
    }
    var INT: AbilityScore {
        return _abilityScores.getReferenceNamed("INT")
    }
    var WIS: AbilityScore {
        return _abilityScores.getReferenceNamed("WIS")
    }
    var CHA: AbilityScore {
        return _abilityScores.getReferenceNamed("CHA")
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
    var classObj: ClassObject {
        get {
            return DBManager.fetchClassObjectFromDatabase(_className, level: _level)
        }
    }
    var raceObj: RaceObject {
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
    var baseAttackBonus: [Int] {
        get {
            return classObj.baseAttackBonus
        }
    }
    var specialAbilities: [SpecialAbilityObject] {
        get {
            return classObj.specialAbilities
        }
    }
    
    func skillTotalFor(skillName: String) -> Int {
        
        let baseSkillValue = _skills.getReferenceNamed(skillName).ranks
        let classSkillBonus = calcClassSkillBonus(skillName)
        let abilityModifierBonus = calcAbilityModifierBonus(skillName)
        
        return baseSkillValue + classSkillBonus + abilityModifierBonus
    }
    
    func calcClassSkillBonus(skillName: String) -> Int {

        let classSkills = classObj.classSkills, currentRanks = _skills.getReferenceNamed(skillName).ranks
        
        if classSkills[skillName] == true  &&  currentRanks > 0 {
            return 3
        }
        
        return 0
    }
    
    func calcAbilityModifierBonus(skillName: String) -> Int {
        
        let skillReference = _skills.getReferenceNamed(skillName)
        let abilityModifierBonus = _abilityScores.getReferenceNamed(skillReference.getKeyAbilityName()).modifier
        return abilityModifierBonus
    }
}

