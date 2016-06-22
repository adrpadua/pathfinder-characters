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
    
    static var fileName = "Classes_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Classes"]
    static var count = database.count
    
    
    
    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    
    static func getStartingGold(json: JSON) -> Int {
        return json["starting_gold"].intValue
    }
    
    static func getHitDie(json: JSON) -> Int {
        return json["hit_die"].intValue
    }
    
    static func getSkillRanksPerLevel(json: JSON) -> Int {
        return json["skill_ranks_per_level"].intValue
    }
    
    static func getClassSkills(json: JSON) -> [String : Bool] {
        let classSkillsJSON = json["class_skills"]
        return createStringToBoolDictionaryFromJSONDirectory(classSkillsJSON)
    }

}


