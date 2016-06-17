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
        if let feat = FeatsDB.getElementFromName(featName) {
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