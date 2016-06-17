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
}

class SpellsDB: Database {
    
    typealias ItemType = Spell
    
    static var fileName = "Spells_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells"]
    static var count = database.count
    
    static func getElementFromName(elementName: String) -> SpellsDB.ItemType? {
        // Woot Woot linear search
        
        for index in 1...count {
            let name = database["\(index)", "name"].stringValue
            
            // Spell object in JSON found
            if name == elementName {
                
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
        return nil
    }
    
    /*
    func getElementFromName(elementName: String) -> Spell? {
        
        // Woot Woot linear search
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let spellsDB = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Spells"]
        let count = spellsDB.count
        
        for index in 1...count {
            let name = spellsDB["\(index)", "name"].stringValue
            
            // Spell object in JSON found
            if name == elementName {
                
                let school = spellsDB["\(index)", "school"].stringValue
                let short_description = spellsDB["(index)", "short_description"].stringValue
                
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
                
                return Spell(name: name, school: school, classLevels: classLevels, short_description: short_description)
            }
        }
        return nil
    }
 */
}

class FeatsDB {
    
    let path: String = NSBundle.mainBundle().pathForResource("Feats_PFRPG_Core", ofType: "json") as String!
    
    func getFeatFromDB(featName: String) -> Feat? {
        
        // Woot Woot linear search
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let featsDB = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
        let count = featsDB.count
        print(count)
        
        for index in 1...count {
            let name = featsDB["\(index)", "name"].stringValue
            print(name)
            
            if name == featName {
                var prereqs: String
                if  featsDB["\(index)", "prerequisites"].stringValue == "" {
                    prereqs = "None"
                } else {
                    prereqs = featsDB["\(index)", "prerequisites"].stringValue
                }
                let type = featsDB["\(index)", "type"].stringValue
                let benefit = featsDB["\(index)", "benefit"].stringValue
                
                print(benefit)
                return Feat(name: name, prereqs: prereqs, type: type , benefits: benefit)
            }
        }
        return nil
    }
}