//
//  SkillsDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/20/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class SkillsDB: Database {
    
    static var fileName = "Skills_PFRPG_Master"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Skills"]
    static var count = database.count
    
    
    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    
    static func getKeyAbility(json: JSON) -> String {
        return json["key_ability"].stringValue
    }
}