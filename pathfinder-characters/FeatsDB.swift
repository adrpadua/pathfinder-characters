//
//  FeatsDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/20/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeatsDB: Database {
    
    static var fileName = "Feats_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
    static var count = database.count
    
    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    
    static func getPrerequisites(json: JSON) -> String {
        if  json["prerequisites"].stringValue.isEmpty {
            return "None"
        }
        return json["prerequisites"].stringValue
    }
    
    static func getType(json: JSON) -> String {
        return json["type"].stringValue
    }
    
    static func getBenefit(json: JSON) -> String {
        return json["benefit"].stringValue
    }
}