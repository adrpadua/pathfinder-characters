//
//  ClassDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/20/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClassDB: Database {
    
    typealias ItemType = CharacterClass
    
    static var fileName = "Classes_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Classes"]
    static var count = database.count
    
    static func getElementFromNumber(index: Int) -> ClassDB.ItemType? {
        
        let name = parseJSONStringValue(index, subJSON: "name")
        let gold = parseJSONIntValue(index, subJSON: "starting_gold")
        let hitDie = parseJSONIntValue(index, subJSON: "hit_die")
        let skillRanks = parseJSONIntValue(index, subJSON: "skill_ranks_per_level")
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


