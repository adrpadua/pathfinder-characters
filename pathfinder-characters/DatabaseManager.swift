//
//  DBManager.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/20/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class DBManager {
    
    static func getClassObjectFromDB(name: String, level: Int) -> CharacterClass {
        let jsonLocation = ClassDB.getJSONDirectoryOf(name)
        
        let classObj = CharacterClass()
        
        classObj.name = ClassDB.getName(jsonLocation)
        classObj.startingGold = ClassDB.getStartingGold(jsonLocation)
        classObj.hitDie = ClassDB.getHitDie(jsonLocation)
        classObj.level = level
        classObj.skillRanksPerLevel = ClassDB.getSkillRanksPerLevel(jsonLocation)
        classObj.classSkills = ClassDB.getClassSkills(jsonLocation)
        
        return classObj
    }
    
    static func getSkillObjectFromDB(name: String) -> Skill {
        let jsonLocation = SkillsDB.getJSONDirectoryOf(name)
        
        let skillObj = Skill()
        
        skillObj.name = SkillsDB.getName(jsonLocation)
        skillObj.keyAbility = SkillsDB.getKeyAbility(jsonLocation)
        
        return skillObj
    }
    
    static func getFeatObjectFromDB(name: String) -> Feat {
        let jsonLocation = FeatsDB.getJSONDirectoryOf(name)
        
        let featObj = Feat()
        
        featObj.name = FeatsDB.getName(jsonLocation)
        featObj.prereqs = FeatsDB.getPrerequisites(jsonLocation)
        featObj.type = FeatsDB.getType(jsonLocation)
        featObj.benefits = FeatsDB.getBenefit(jsonLocation)
        
        return featObj
    }
    
    static func getSpellObjectFromDB(name: String) -> Spell {
        let jsonLocation = SpellsDB.getJSONDirectoryOf(name)
        
        let spellObj = Spell()
        
        spellObj.name = SpellsDB.getName(jsonLocation)
        spellObj.school = SpellsDB.getSchool(jsonLocation)
        spellObj.short_description = SpellsDB.getShortDescription(jsonLocation)
        spellObj.classLevels = SpellsDB.getClassLevels(jsonLocation)
        
        return spellObj
    }
    
    static func getRaceObjectFromDB(name: String) -> Race {
        let jsonLocation = RaceDB.getJSONDirectoryOf(name)
        
        let raceObj = Race()
        
        raceObj.name = RaceDB.getName(jsonLocation)
        raceObj.abilityScoreBonuses = RaceDB.getAbilityScoreBonuses(jsonLocation)
        raceObj.speed = RaceDB.getSpeed(jsonLocation)
        raceObj.size = RaceDB.getSize(jsonLocation)
        raceObj.languages = RaceDB.getStartingLanguages(jsonLocation)
        
        return raceObj
    }
    
    static func getEquipmentObjectFromDB(name: String) -> Equipment {
        
        if WeaponDB.indexOf(name) != -1 {
            return getWeaponObjectFromDB(name)
        } else if ArmorDB.indexOf(name) != -1 {
            return getArmorObjectFromDB(name)
        }
        
        return Equipment()
    }
    
    static func getWeaponObjectFromDB(name: String) -> Weapon {
        let jsonLocation = WeaponDB.getJSONDirectoryOf(name)
        
        let weaponObj = Weapon()
        
        weaponObj.name = WeaponDB.getName(jsonLocation)
        weaponObj.weapon_category = WeaponDB.getCategory(jsonLocation)
        weaponObj.classification = WeaponDB.getClassification(jsonLocation)
        
        // TODO: Finish Implementation
        
        print("Found \(weaponObj.name)")
        return weaponObj
    }
    
    static func getArmorObjectFromDB(name: String) -> Armor {
        let jsonLocation = ArmorDB.getJSONDirectoryOf(name)
        
        let armorObj = Armor()
        
        armorObj.name = WeaponDB.getName(jsonLocation)
        armorObj.classification = WeaponDB.getClassification(jsonLocation)
        
        // TODO: Finish Implementation
        
        print("Found \(armorObj.name)")
        return armorObj
    }
}