//
//  ArmorDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/21/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArmorDB: Database {
    
    static var fileName = "Equipment_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Armor"]
    static var count = database.count
    
    
    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    static func getClassification(json: JSON) -> String {
        return json["classification"].stringValue
    }
    static func getGPCost(json: JSON) -> Int {
        return json["cost", "cost_gp"].intValue
    }
    static func getACBonus(json: JSON) -> Int {
        return json["ac_bonus"].intValue
    }
    static func getMaxDexBonus(json: JSON) -> Int {
        return json["max_dex_bonus"].intValue
    }
    static func getArcaneSpellFailChance(json: JSON) -> Double {
        return json["arcane_spell_failure_chance"].doubleValue
    }
    static func getSpeed30(json: JSON) -> Int {
        return json["speed_30"].intValue
    }
    static func getSpeed20(json: JSON) -> Int {
        return json["speed_20"].intValue
    }
    static func getWeight(json: JSON) -> Double {
        return json["weight"].doubleValue
    }
}


