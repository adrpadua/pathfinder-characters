//
//  File.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/14/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Spell {
    
    var name: String?
    var school: String?
    var classLevels: [String : Int]?
    var short_description: String?
    
    init(name: String, school: String, classLevels: [String : Int], short_description: String) {
        self.name = name
        self.school = school
        self.classLevels = classLevels
        self.short_description = short_description
    }
}


class SpellList {
    
    var parentPlayerCharacter: PlayerCharacter?
    
}

class PreparedSpells: SpellList {
    
}

class KnownSpells: SpellList {
    
}
