//
//  SkillReferenceName.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/24/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class SkillReferenceName: Object, ReferenceName {
    
    dynamic var name = ""
    dynamic var ranks = 0
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> ReferenceObject {
        return DBManager.fetchSkillObjectFromDatabase(name)
    }
    
    func getKeyAbilityName() -> String {
        return DBManager.fetchSkillObjectFromDatabase(name).keyAbility
    }
}