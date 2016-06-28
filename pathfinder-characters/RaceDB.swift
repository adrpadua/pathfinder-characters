//
//  RaceDB.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/21/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON

class RaceDB: Database {
    
    static var fileName = "Races_PFRPG_Core"
    static var path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")! as String
    static var jsonData = NSData(data: NSData(contentsOfFile: path)!)
    static var database = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Races"]
    static var count = database.count
    
    
    
    // GETTERS
    static func getName(json: JSON) -> String {
        return json["name"].stringValue
    }
    
    static func getAbilityScoreRacialBonuses(json: JSON) -> [String : Int] {
        let scoreBonusesJSON = json["ability_score_bonuses"]
        return createStringToIntDictionaryFromJSONDirectory(scoreBonusesJSON)
    }
    
    static func getSpeed(json: JSON) -> (String, Int) {
        let description = json["speed_description"].stringValue
        let speedValue = json["speed"].intValue
        return (description, speedValue)
    }
    
    static func getSize(json: JSON) -> String {
        return json["size"].stringValue
    }
    
    static func getStartingLanguages(json: JSON) -> [String] {
        let languagesJSON = json["starting_languages"]
        return createStringArrayFromJSONDirectory(languagesJSON)
    }
    
    static func getRacialTraits(json: JSON) -> [String : String] {
        let racialTraitsJSON = json["racial_traits"]
        return createStringToStringDictionaryFromJSONDirectory(racialTraitsJSON)
    }
    
}
