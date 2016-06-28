//
//  SpellReferenceName.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/24/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

enum SpellTags: String {
    case Untagged, PreparedSpell, ClassSpell, DomainSpell
}

class SpellReferenceName: Object, ReferenceName {
    
    dynamic var name = ""
    dynamic var level = 0
    dynamic var tag = SpellTags.Untagged.rawValue
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> ReferenceObject {
        return DBManager.fetchSpellObjectFromDatabase(name)
    }
}