//
//  WeaponDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/21/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeaponDB: Database {
    
    static var fileName = "Equipment_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Weapons"]
    static var count = database.count
    
    
    
    // Property Getters
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    static func getCategory(json: JSON) -> String {
        return json["weapon_category"].stringValue
    }
    static func getClassification(json: JSON) -> String {
        return json["classification"].stringValue
    }
    static func getGPCost(json: JSON) -> Int {
        return json["cost", "cost_gp"].intValue
    }
    static func getSPCost(json: JSON) -> Int {
        return json["cost", "cost_sp"].intValue
    }
    static func getDamageS(json: JSON) -> String {
        return json["damage_s"].stringValue
    }
    static func getDamageM(json: JSON) -> String {
        return json["damage_m"].stringValue
    }
    static func getCritMult(json: JSON) -> Int {
        return json["crit_multiplier"].intValue
    }
    static func getCritRoll(json: JSON) -> Int {
        return json["crit_roll"].intValue
    }
    static func getRange(json: JSON) -> Int {
        if json["crit_roll"].stringValue == "Melee" {
            return 0
        }
        return json["crit_roll"].intValue
    }
    static func getWeight(json: JSON) -> Double {
        return json["weight"].doubleValue
    }
    
    static func getSpecials(json: JSON) -> [String : Bool] {
        let specialsJSON = json["special"]
        return createStringToBoolDictionaryFromJSONDirectory(specialsJSON)
    }
    
    static func getDamageTypes(json: JSON) -> [String : Bool] {
        let damagesJSON = json["special"]
        return createStringToBoolDictionaryFromJSONDirectory(damagesJSON)
    }
}


