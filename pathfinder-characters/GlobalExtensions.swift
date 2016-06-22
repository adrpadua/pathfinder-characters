//
//  GlobalExtensions.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/22/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
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



extension PlayerCharacter {
    var STR: AbilityScore {
        return pc_abilityScores.getItemNamed("STR")
    }
    var DEX: AbilityScore {
        return pc_abilityScores.getItemNamed("DEX")
    }
    var CON: AbilityScore {
        return pc_abilityScores.getItemNamed("CON")
    }
    var INT: AbilityScore {
        return pc_abilityScores.getItemNamed("INT")
    }
    var WIS: AbilityScore {
        return pc_abilityScores.getItemNamed("WIS")
    }
    var CHA: AbilityScore {
        return pc_abilityScores.getItemNamed("CHA")
    }
    var Fortitude: Int {
        return pc_savingThrows["Fortitude"]!
    }
    var Reflex: Int {
        return pc_savingThrows["Reflex"]!
    }
    var Willpower: Int {
        return pc_savingThrows["Willpower"]!
    }
}

extension List {
    func getItemNamed(name: String) -> T {
        
        let object = self.filter("name == %@", "\(name)")[0]
        
        return object
    }
}

extension String {
    var isNotEmpty: Bool  {
        if self == "" {
            return false
        }
        return true
    }
}











