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
    
    static func fetchClassObjectFromDatabase(name: String, level: Int) -> ClassObject {
        let jsonLocation = ClassDB.getJSONDirectoryOf(name)
        
        let classObj = ClassObject()
        
        classObj.name = ClassDB.getName(jsonLocation)
        classObj.startingGold = ClassDB.getStartingGold(jsonLocation)
        classObj.hitDie = ClassDB.getHitDie(jsonLocation)
        classObj.level = level
        classObj.skillRanksPerLevel = ClassDB.getSkillRanksPerLevel(jsonLocation)
        classObj.classSkills = ClassDB.getClassSkills(jsonLocation)
        classObj.baseAttackBonus = ClassDB.getBaseAttackBonus(jsonLocation, level: level)
        
        return classObj
    }
    
    static func fetchClassAbilitiesArrayFromDatabase(className: String, level: Int) -> [SpecialAbilityObject] {
        let jsonLocation = ClassDB.getJSONDirectoryOf(className)["level"]
        
        var specialAbilities = [SpecialAbilityObject]()
        
        for index in 1...level {
            let specialAbilitiesJSONDirectory = jsonLocation["\(index)", "special_abilities"]
            
            for (index,_):(String, JSON) in specialAbilitiesJSONDirectory {
                let indexInt = Int(index)
                
                if specialAbilitiesJSONDirectory.arrayValue[indexInt!]["replaces"].stringValue != "NULL" {
                    let newItemJSON = specialAbilitiesJSONDirectory.arrayValue[indexInt!]
                    let nameToReplace = specialAbilitiesJSONDirectory.arrayValue[indexInt!]["replaces"].stringValue
                    replaceSpecialAbilityFromJSON(nameToReplace, inCollection: specialAbilities, withJSON: newItemJSON)
                    continue
                }
                
                else {
                    let newItemJSON = specialAbilitiesJSONDirectory.arrayValue[indexInt!]
                    let newObj = createSpecialAbilityFromJSON(newItemJSON)
                    specialAbilities.append(newObj)
                }
            }
        }
        return specialAbilities
    }
    
    static func fetchSkillObjectFromDatabase(name: String) -> SkillObject {
        let jsonLocation = SkillsDB.getJSONDirectoryOf(name)
        
        let skillObj = SkillObject()
        
        skillObj.name = SkillsDB.getName(jsonLocation)
        skillObj.keyAbility = SkillsDB.getKeyAbility(jsonLocation)
        
        return skillObj
    }
    
    static func fetchFeatObjectFromDatabase(name: String) -> FeatObject {
        let jsonLocation = FeatsDB.getJSONDirectoryOf(name)
        
        let featObj = FeatObject()
        
        featObj.name = FeatsDB.getName(jsonLocation)
        featObj.prereqs = FeatsDB.getPrerequisites(jsonLocation)
        featObj.type = FeatsDB.getType(jsonLocation)
        featObj.benefits = FeatsDB.getBenefit(jsonLocation)
        
        return featObj
    }
    
    static func fetchClassSpellsFromDatabase(className: String) -> [SpellReferenceName] {
        let jsonLocation = SpellsDB.database
        let lowerCaseClassName = className.lowercaseString
        
        var spellRefs = [SpellReferenceName]()
        
        for index in 1...jsonLocation.count {
            let spellLevelJson = jsonLocation["\(index)", "spell_level"]
            
            for (classIndex,_):(String, JSON) in spellLevelJson {
                
                if classIndex == lowerCaseClassName && spellLevelJson[classIndex] != "NULL" {
                    
                    let spellRef = SpellReferenceName()
                    
                    spellRef.name = jsonLocation["\(index)", "name"].stringValue
                    spellRef.level = spellLevelJson[classIndex].intValue
                    spellRef.tag = SpellTags.ClassSpell.rawValue
                    
                    spellRefs.append(spellRef)
                }
            }
        }
        
        return spellRefs
    }
    
    static func fetchSpellObjectFromDatabase(name: String) -> SpellObject {
        let jsonLocation = SpellsDB.getJSONDirectoryOf(name)
        
        let spellObj = SpellObject()
        
        spellObj.name = SpellsDB.getName(jsonLocation)
        spellObj.school = SpellsDB.getSchool(jsonLocation)
        spellObj.short_description = SpellsDB.getShortDescription(jsonLocation)
        spellObj.classLevels = SpellsDB.getClassLevels(jsonLocation)
        
        return spellObj
    }
    
    static func fetchRaceObjectFromDatabase(name: String) -> RaceObject {
        let jsonLocation = RaceDB.getJSONDirectoryOf(name)
        
        let raceObj = RaceObject()
        
        raceObj.name = RaceDB.getName(jsonLocation)
        raceObj.abilityScoreRacialBonuses = RaceDB.getAbilityScoreRacialBonuses(jsonLocation)
        raceObj.speed = RaceDB.getSpeed(jsonLocation)
        raceObj.size = RaceDB.getSize(jsonLocation)
        raceObj.languages = RaceDB.getStartingLanguages(jsonLocation)
        
        return raceObj
    }
    
    static func fetchRacialAbilitiesFromDatabase(raceName: String) -> [SpecialAbilityObject] {
        let jsonLocation = RaceDB.getJSONDirectoryOf(raceName)["racial_traits"]
        return createSpecialAbilitiesArrayFromJSON(jsonLocation)
    }
    
    static func fetchEquipmentObjectFromDatabase(name: String) -> EquipmentObject {
        
        if WeaponDB.includes(name){
            return fetchWeaponObjectFromDatabase(name)
        } else if ArmorDB.includes(name) {
            return fetchArmorObjectFromDatabase(name)
        }
        
        return EquipmentObject()
    }
    
    private static func fetchWeaponObjectFromDatabase(name: String) -> WeaponObject {
        let jsonLocation = WeaponDB.getJSONDirectoryOf(name)
        
        let weaponObj = WeaponObject()
        
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
    
    private static func fetchArmorObjectFromDatabase(name: String) -> ArmorObject {
        let jsonLocation = ArmorDB.getJSONDirectoryOf(name)
        
        let armorObj = ArmorObject()
        
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
    
    static func fetchDomainObjectFromDatabase(name: String) -> DomainObject {
        let jsonLocation = DomainsDB.getJSONDirectoryOf(name)
        
        let domainObj = DomainObject()
        
        domainObj.name = DomainsDB.getName(jsonLocation)
        domainObj.description = DomainsDB.getDescription(jsonLocation)
        
        let specialAbility1JSON = jsonLocation["special_abilities"].arrayValue[0]
        let specialAbility2JSON = jsonLocation["special_abilities"].arrayValue[1]
        
        domainObj.specialAbility1 = createSpecialAbilityFromJSON(specialAbility1JSON)
        domainObj.specialAbility2 = createSpecialAbilityFromJSON(specialAbility2JSON)
        
        var spellRefs = [SpellReferenceName]()
        let domainSpells = DomainsDB.getDomainSpells(jsonLocation)
        for index in 1...9 {
            let spellRef = SpellReferenceName()
            spellRef.level = index
            spellRef.name = domainSpells[index]!
            spellRef.tag = SpellTags.DomainSpell.rawValue
            spellRefs.append(spellRef)
            print(spellRef)
        }
        domainObj.domainSpells = spellRefs
        
        return domainObj
    }
}

extension DBManager {
    
    static func createSpecialAbilityFromJSON(json: JSON) -> SpecialAbilityObject {
        
        let specialAbilityObj = SpecialAbilityObject()
        
        specialAbilityObj.name = json["name"].stringValue
        
        if json["type"].stringValue == "NULL" {
            specialAbilityObj.type = "(Standard)"
        } else {
            specialAbilityObj.type = "(\(json["type"].stringValue))"
        }
        
        specialAbilityObj.tag = json["tag"].stringValue
        specialAbilityObj.description = json["description"].stringValue
        
        return specialAbilityObj
    }
    
    static func createSpecialAbilitiesArrayFromJSON(json: JSON) -> [SpecialAbilityObject] {
        
        var specialAbilityArray = [SpecialAbilityObject]()
        
        for (index,_):(String, JSON) in json {
            let indexInt = Int(index)
            
            if json.arrayValue[indexInt!]["replaces"].stringValue != "NULL" {
                let newItemJSON = json.arrayValue[indexInt!]
                let nameToReplace = json.arrayValue[indexInt!]["replaces"].stringValue
                replaceSpecialAbilityFromJSON(nameToReplace, inCollection: specialAbilityArray, withJSON: newItemJSON)
                continue
            }
                
            else {
                let newItemJSON = json.arrayValue[indexInt!]
                let newObj = createSpecialAbilityFromJSON(newItemJSON)
                specialAbilityArray.append(newObj)
            }
        }
        
        return specialAbilityArray
    }
    
    static func replaceSpecialAbilityFromJSON(replace: String, inCollection: [SpecialAbilityObject] , withJSON: JSON) {
        
        for object in inCollection {
            if object.isNamed(replace) {
                object.name = withJSON["name"].stringValue
                object.type = withJSON["type"].stringValue
                object.description = withJSON["description"].stringValue
            }
        }
    }
}