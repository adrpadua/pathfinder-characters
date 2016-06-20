//
//  SpellsDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/20/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpellsDB: Database {
    
    static var fileName = "Spells_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells"]
    static var count = database.count

    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    
    static func getSchool(json: JSON) -> String {
        return json["school"].stringValue
    }
    
    static func getShortDescription(json: JSON) -> String {
        return json["short_description"].stringValue
    }
    
    static func getClassLevels(json: JSON) -> [String : Int] {
        
        var classLevels = [String : Int]()
        
        let classLevelsJSON = json["spell_level"]
        
        for (key, _):(String, JSON) in classLevelsJSON {
            
            guard classLevelsJSON[key].stringValue != "NULL" else {
                continue
            }
            classLevels[key] = classLevelsJSON[key].intValue
        }
        
        return classLevels
    }
}