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
    
    associatedtype ItemType
    init(name: String)
    
    func toObject() -> ItemType
}

class EquipmentReferenceName: Object, ReferenceName {
    
    typealias ItemType = EquipmentObject
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> EquipmentReferenceName.ItemType {
        return DBManager.fetchEquipmentObjectFromDatabase(self.name)
    }
}

class FeatReferenceName: Object, ReferenceName {
    
    typealias ItemType = FeatObject
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> FeatReferenceName.ItemType {
        return DBManager.fetchFeatObjectFromDatabase(self.name)
    }
}


class SpellReferenceName: Object, ReferenceName {
    
    typealias ItemType = SpellObject
    dynamic var name = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
    
    func toObject() -> SpellReferenceName.ItemType {
        return DBManager.fetchSpellObjectFromDatabase(self.name)
    }
}