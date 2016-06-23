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
    
    static func fetchClassObjectFromDatabase(name: String, level: Int) -> CharacterClass {
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
    
    static func fetchSkillObjectFromDatabase(name: String) -> Skill {
        let jsonLocation = SkillsDB.getJSONDirectoryOf(name)
        
        let skillObj = Skill()
        
        skillObj.name = SkillsDB.getName(jsonLocation)
        skillObj.keyAbility = SkillsDB.getKeyAbility(jsonLocation)
        
        return skillObj
    }
    
    static func fetchFeatObjectFromDatabase(name: String) -> Feat {
        let jsonLocation = FeatsDB.getJSONDirectoryOf(name)
        
        let featObj = Feat()
        
        featObj.name = FeatsDB.getName(jsonLocation)
        featObj.prereqs = FeatsDB.getPrerequisites(jsonLocation)
        featObj.type = FeatsDB.getType(jsonLocation)
        featObj.benefits = FeatsDB.getBenefit(jsonLocation)
        
        return featObj
    }
    
    static func fetchSpellObjectFromDatabase(name: String) -> Spell {
        let jsonLocation = SpellsDB.getJSONDirectoryOf(name)
        
        let spellObj = Spell()
        
        spellObj.name = SpellsDB.getName(jsonLocation)
        spellObj.school = SpellsDB.getSchool(jsonLocation)
        spellObj.short_description = SpellsDB.getShortDescription(jsonLocation)
        spellObj.classLevels = SpellsDB.getClassLevels(jsonLocation)
        
        return spellObj
    }
    
    static func fetchRaceObjectFromDatabase(name: String) -> Race {
        let jsonLocation = RaceDB.getJSONDirectoryOf(name)
        
        let raceObj = Race()
        
        raceObj.name = RaceDB.getName(jsonLocation)
        raceObj.abilityScoreRacialBonuses = RaceDB.getAbilityScoreRacialBonuses(jsonLocation)
        raceObj.speed = RaceDB.getSpeed(jsonLocation)
        raceObj.size = RaceDB.getSize(jsonLocation)
        raceObj.languages = RaceDB.getStartingLanguages(jsonLocation)
        
        return raceObj
    }
    
    static func fetchEquipmentObjectFromDatabase(name: String) -> Equipment {
        
        if WeaponDB.includes(name){
            return fetchWeaponObjectFromDatabase(name)
        } else if ArmorDB.includes(name) {
            return fetchArmorObjectFromDatabase(name)
        }
        
        return Equipment()
    }
    
    private static func fetchWeaponObjectFromDatabase(name: String) -> Weapon {
        let jsonLocation = WeaponDB.getJSONDirectoryOf(name)
        
        let weaponObj = Weapon()
        
        weaponObj.name = WeaponDB.getName(jsonLocation)
        weaponObj.weapon_category = WeaponDB.getCategory(jsonLocation)
        weaponObj.classification = WeaponDB.getClassification(jsonLocation)
        weaponObj.cost_gp = WeaponDB.getGPCost(jsonLocation)
        weaponObj.cost_sp = WeaponDB.getSPCost(jsonLocation)
        weaponObj.medWeight = WeaponDB.getWeight(jsonLocation)
        weaponObj.weapon_category = WeaponDB.getCategory(jsonLocation)
        weaponObj.damage_s = WeaponDB.getDamageS(jsonLocation)
        weaponObj.damage_m = WeaponDB.getDamageM(jsonLocation)
        weaponObj.crit_multiplier = WeaponDB.getCritMult(jsonLocation)
        weaponObj.crit_roll = WeaponDB.getCritRoll(jsonLocation)
        weaponObj.range = WeaponDB.getRange(jsonLocation)
        weaponObj.damage_type = WeaponDB.getDamageTypes(jsonLocation)
        weaponObj.special = WeaponDB.getSpecials(jsonLocation)
        
        print("Found \(weaponObj.name)")
        return weaponObj
    }
    
    private static func fetchArmorObjectFromDatabase(name: String) -> Armor {
        let jsonLocation = ArmorDB.getJSONDirectoryOf(name)
        
        let armorObj = Armor()
        
        armorObj.name = ArmorDB.getName(jsonLocation)
        armorObj.classification = ArmorDB.getClassification(jsonLocation)
        armorObj.cost_gp = ArmorDB.getGPCost(jsonLocation)
        armorObj.medWeight = ArmorDB.getWeight(jsonLocation)
        armorObj.ac_bonus = ArmorDB.getACBonus(jsonLocation)
        armorObj.max_dex_bonus = ArmorDB.getMaxDexBonus(jsonLocation)
        armorObj.armor_check_penalty = ArmorDB.getArmorCheckPenalty(jsonLocation)
        armorObj.arcane_spell_fail_chance = ArmorDB.getArcaneSpellFailChance(jsonLocation)
        armorObj.speed_30 = ArmorDB.getSpeed30(jsonLocation)
        armorObj.speed_20 = ArmorDB.getSpeed20(jsonLocation)
        
        print("Found \(armorObj.name)")
        return armorObj
    }
}