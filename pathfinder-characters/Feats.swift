//
//  Feats.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/14/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class FeatsDB {
    
    var numberOfFeats = 0
    let path: String = NSBundle.mainBundle().pathForResource("Feats_PFRPG_Core", ofType: "json") as String!
    
    func getFeatFromDB(featName: String) -> Feat? {
        
        // Woot Woot linear search
        let jsonData = NSData(contentsOfFile: path) as NSData!
        let featsDB = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)["Feats"]
        let count = featsDB.count
        
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

class FeatsList: Object {
    
    dynamic var parentPlayerCharacter: PlayerCharacter?
    
    let feats = List<Feat>()
    
    func findFeatWithName(name: String) -> Feat? {
        let featResults = feats.filter("name == %@", "\(name)")
        
        if featResults.isEmpty {
            return nil
        } else {
            return featResults[0]
        }
    }
    
    func addFeat(featName: String) {
        
        let db = FeatsDB()
        
        if let feat = db.getFeatFromDB(featName) {
            feats.append(feat)
        } else {
            print("addFeat() error")
        }
        
    }
}

class Feat: Object {
    
    dynamic var name = ""
    dynamic var type = ""
    dynamic var prereqs = ""
    dynamic var benefits = ""
    
    convenience init(name: String, prereqs: String, type: String, benefits: String) {
        self.init()
        self.name = name
        self.type = type
        self.prereqs = prereqs
        self.benefits = benefits
        
    }
}