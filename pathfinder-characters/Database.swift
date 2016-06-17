//
//  Database.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Database {
    
    associatedtype ItemType
    static var fileName: String { get set }
    static var path: String { get set }
    static var jsonData: NSData { get set }
    static var database: JSON { get set }
    static var count: Int { get set }
    
    static func getElementFromName(elementName: String) -> ItemType?
    static func extractDataAt(index: Int) -> ItemType?
}

func indexOf(name: String, insideDB: JSON) -> Int {
    for index in 1...insideDB.count {
        if name == insideDB["\(index)", "name"].stringValue {
            return index
        }
    }
    return -1
}

class FeatsDB: Database {
    
    typealias ItemType = Feat
    
    static var fileName = "Feats_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
    static var count = database.count
    
    
    
    
    
    
    static func getElementFromName(elementName: String) -> FeatsDB.ItemType? {
        
        return extractDataAt(indexOf(elementName, insideDB: database))
    }
    
    
    
    
    // Create Data based on JSON Index
    static func extractDataAt(index: Int) -> FeatsDB.ItemType? {var prereqs: String
        
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
    
    
    
    
    
    static func getElementFromName(elementName: String) -> SpellsDB.ItemType? {
        
        return extractDataAt(indexOf(elementName, insideDB: database))
    }
    
    
    
    
    // Create Data based on JSON Index
    static func extractDataAt(index: Int) -> SpellsDB.ItemType? {
        
        let name = database["\(index)", "name"].stringValue
        let school = database["\(index)", "school"].stringValue
        let short_description = database["(index)", "short_description"].stringValue
        
        var classLevels = [String : Int]()
        
        // Create subJSON to get the thing
        let classLevelsJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells", "\(index)", "spell_level"]
        
        // Do the thing
        for (key, _):(String, JSON) in classLevelsJSON {
            
            guard classLevelsJSON[key].stringValue != "NULL" else {
                continue
            }
            classLevels[key] = classLevelsJSON[key].intValue
        }
        
        print("Found \(name)")
        return Spell(name: name, school: school, classLevels: classLevels, short_description: short_description)
    }
}

