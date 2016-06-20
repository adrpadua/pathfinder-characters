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
    
    static func getClassObject(name: String, level: Int) -> CharacterClass {
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
    
    static func getSkillObject(name: String) -> Skill {
        let jsonLocation = SkillsDB.getJSONDirectoryOf(name)
        
        let skillObj = Skill()
        
        skillObj.name = SkillsDB.getName(jsonLocation)
        skillObj.keyAbility = SkillsDB.getKeyAbility(jsonLocation)
        
        return skillObj
    }
    
    static func getFeatObject(name: String) -> Feat {
        let jsonLocation = FeatsDB.getJSONDirectoryOf(name)
        
        let featObj = Feat()
        
        featObj.name = FeatsDB.getName(jsonLocation)
        featObj.prereqs = FeatsDB.getPrerequisites(jsonLocation)
        featObj.type = FeatsDB.getType(jsonLocation)
        featObj.benefits = FeatsDB.getBenefit(jsonLocation)
        
        return featObj
    }
    
    static func getSpellObject(name: String) -> Spell {
        let jsonLocation = SpellsDB.getJSONDirectoryOf(name)
        
        let spellObj = Spell()
        
        spellObj.name = SpellsDB.getName(jsonLocation)
        spellObj.school = SpellsDB.getSchool(jsonLocation)
        spellObj.short_description = SpellsDB.getShortDescription(jsonLocation)
        spellObj.classLevels = SpellsDB.getClassLevels(jsonLocation)
        
        return spellObj
    }
}