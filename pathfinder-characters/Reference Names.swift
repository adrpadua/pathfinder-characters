//
//  RealmReferenceName.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/23/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

protocol ReferenceName {
    
    init(name: String)
    
    func toObject() -> ReferenceObject
}

class EquipmentReferenceName: Object, ReferenceName {
    
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> ReferenceObject {
        return DBManager.fetchEquipmentObjectFromDatabase(name)
    }
}

class FeatReferenceName: Object, ReferenceName {
    
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> ReferenceObject {
        return DBManager.fetchFeatObjectFromDatabase(name)
    }
}


class SpellReferenceName: Object, ReferenceName {
    
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> ReferenceObject {
        return DBManager.fetchSpellObjectFromDatabase(name)
    }
}