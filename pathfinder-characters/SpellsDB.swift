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
