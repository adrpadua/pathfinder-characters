//
//  DomainsDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/24/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class DomainsDB: Database {
    static var fileName = "Domains_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Domains"]
    static var count = database.count
    
    
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    static func getDescription(json: JSON) -> String {
        return json["description"].stringValue
    }
    static func getDomainSpells(json: JSON) -> [Int : String] {
        let domainSpellsJSON = json["domain_spells"]
        return createIntToStringDictionaryFromJSONDirectory(domainSpellsJSON)
    }
}