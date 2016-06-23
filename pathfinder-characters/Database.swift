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
    
    static var fileName: String { get set }
    static var path: String { get set }
    static var jsonData: NSData { get set }
    static var database: JSON { get set }
    static var count: Int { get set }
    
}


extension Database {
    
    static func indexOf(name: String) -> Int {
        for index in 1...self.database.count {
            if name == self.database["\(index)", "name"].stringValue {
                return index
            }
        }
        return -1
    }
    
    static func includes(name: String) -> Bool {
        if indexOf(name) == -1 {
            return false
        }
        return true
    }
    
    static func getJSONDirectoryOf(query: String) -> JSON {
        let index = indexOf(query)
        let jsonDirectoryOfQuery = database["\(index)"]
        return jsonDirectoryOfQuery
    }
    
    static func createStringArrayFromJSONDirectory(subJson: JSON) -> [String] {
        
        var createdArray = [String]()
        
        for (index,_):(String, JSON) in subJson {
            createdArray.append(index)
        }
        return createdArray
    }
    
    static func createStringToIntDictionaryFromJSONDirectory(subJson: JSON) -> [String : Int] {
        var createdDictionary = [String : Int]()
        
        for (key, _):(String, JSON) in subJson {
            createdDictionary[key] = subJson[key].intValue
        }
        return createdDictionary
    }
    
    static func createStringToBoolDictionaryFromJSONDirectory(subJson: JSON) -> [String : Bool] {
        var createdDictionary = [String : Bool]()
        for (key, _):(String, JSON) in subJson {
            
            if subJson[key].intValue == 0 {
                createdDictionary[key] = false
            } else if subJson[key].intValue == 1 {
                createdDictionary[key] = true
            }
        }
        return createdDictionary
    }
}












