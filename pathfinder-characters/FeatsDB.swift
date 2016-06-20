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
    
    typealias ItemType = Feat
    
    static var fileName = "Feats_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
    static var count = database.count
    
    
    static func getElementFromNumber(index: Int) -> FeatsDB.ItemType? {
        var prereqs: String
        
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