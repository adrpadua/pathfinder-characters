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