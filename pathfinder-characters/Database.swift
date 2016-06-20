//
//  Database.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Database {
    
    
    static func indexOf(name: String) -> Int {
        for index in 1...self.database.count {
            if name == self.database["\(index)", "name"].stringValue {
                return index
            }
        }
        return -1
    }
    
    static func getJSONDirectoryOf(elementName: String) -> JSON {
        let index = indexOf(elementName)
        let json = database["\(index)"]
        
        return json
    }
    
    static func getElementFromName(elementName: String) -> Self.ItemType? {
        
//        return getElementFromNumber(indexOf(elementName))
        return nil
    }
    
    static func parseJSONStringValue(json: JSON, subJSON: String) -> String {
        
        let value = json["\(subJSON)"].stringValue
        
        return value
    }
    
    
    static func parseJSONIntValue(json: JSON, subJSON: String) -> Int {
        
        let value = json["\(subJSON)"].intValue
        
        return value
    }
    
    
//    
//    static func parseJSONStringValue(index: Int, subJSON: String) -> String {
//        
//        let value = database["\(index)", "\(subJSON)"].stringValue
//        
//        return value
//    }
//    
//    
//    static func parseJSONIntValue(index: Int, subJSON: String) -> Int {
//        
//        let value = database["\(index)", "\(subJSON)"].intValue
//        
//        return value
//    }
    
    
    
}

protocol Database {
    
    associatedtype ItemType
    static var fileName: String { get set }
    static var path: String { get set }
    static var jsonData: NSData { get set }
    static var database: JSON { get set }
    static var count: Int { get set }
    
//    static func getElementFromNumber(index: Int) -> ItemType?
}


























