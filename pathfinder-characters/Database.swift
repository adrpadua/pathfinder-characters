//
//  Database.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Database {
    static func indexOf(name: String) -> Int {
        for index in 1...self.database.count {
            if name == self.database["\(index)", "name"].stringValue {
                return index
            }
        }
        return -1
    }
    static func getElementFromName(elementName: String) -> Self.ItemType? {
        
        return getElementFromNumber(indexOf(elementName))
    }
}





protocol Database {
    
    associatedtype ItemType
    static var fileName: String { get set }
    static var path: String { get set }
    static var jsonData: NSData { get set }
    static var database: JSON { get set }
    static var count: Int { get set }
    
    static func getElementFromNumber(index: Int) -> ItemType?
}









class ClassDB: Database {
    
    typealias ItemType = CharacterClass
    
    static var fileName = "Classes_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Classes"]
    static var count = database.count
    
    static func getElementFromNumber(index: Int) -> ClassDB.ItemType? {
        
        let name = database["\(index)", "name"].stringValue
        let gold = database["\(index)", "starting_gold"].intValue
        let hitDie = database["\(index)", "hit_die"].intValue
        let skillRanks = database["\(index)", "skill_ranks_per_level"].intValue
        let classSkills = getClassSkills(index)
        
        return CharacterClass(name: name, gold: gold, hitDie: hitDie, level: 1, skillRanks: skillRanks, classSkills: classSkills)
        
    }
    
    static func getClassSkills(index: Int) -> [String] {
        
        var classSkills = [String]()
        
        // Create subJSON to get the thing
        let classSkillsJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Classes", "\(index)", "class_skills"]
        
        // Do the thing
        for (key, _):(String, JSON) in classSkillsJSON {
            
            guard classSkillsJSON[key].intValue != 0 else {
                continue
            }
            
            classSkills.append(key)
        }
        
        return classSkills
    }
}











class SkillsDB: Database {
    
    typealias ItemType = Skill
    
    static var fileName = "Skills_PFRPG_Master"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Skills"]
    static var count = database.count
    
    
    static func getElementFromNumber(index: Int) -> SkillsDB.ItemType? {
        
        let name = database["\(index)", "name"].stringValue
        let keyAbility = database["\(index)", "key_ability"].stringValue
        
        return Skill(name: name, ability: keyAbility)
    }
}











class FeatsDB: Database {
    
    typealias ItemType = Feat
    
    static var fileName = "Feats_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
    static var count = database.count
    
    
    static func getElementFromNumber(index: Int) -> FeatsDB.ItemType? {
        var prereqs: String
        
        let name = database["\(index)", "name"].stringValue
        if  database["\(index)", "prerequisites"].stringValue == "" {
            prereqs = "None"
        } else {
            prereqs = database["\(index)", "prerequisites"].stringValue
        }
        let type = database["\(index)", "type"].stringValue
        let benefit = database["\(index)", "benefit"].stringValue
        
        print("Found \(name)")
        return Feat(name: name, prereqs: prereqs, type: type , benefits: benefit)
    }
    
    
}










class SpellsDB: Database {
    
    
    
    typealias ItemType = Spell
    
    static var fileName = "Spells_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells"]
    static var count = database.count
    
    static func getElementFromNumber(index: Int) -> SpellsDB.ItemType? {
        
        let name = database["\(index)", "name"].stringValue
        let school = database["\(index)", "school"].stringValue
        let short_description = database["(index)", "short_description"].stringValue
        let classLevels = getClasslevels(index)
        
        
        print("Found \(name)")
        return Spell(name: name, school: school, classLevels: classLevels, short_description: short_description)
    }
    
    static func getClasslevels(index: Int) -> [String : Int] {
        
        var classLevels = [String : Int]()
        
        let classLevelsJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells", "\(index)", "spell_level"]
        
        for (key, _):(String, JSON) in classLevelsJSON {
            
            guard classLevelsJSON[key].stringValue != "NULL" else {
                continue
            }
            classLevels[key] = classLevelsJSON[key].intValue
        }
        
        return classLevels
    }
}


