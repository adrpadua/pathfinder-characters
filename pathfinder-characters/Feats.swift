//
//  Feats.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/14/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class Feat: Object {
    
//    let partOfCharacter = LinkingObjects(fromType: PlayerCharacter.self, property: "pc_feats")
    
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