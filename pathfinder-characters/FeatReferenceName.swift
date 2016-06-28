//
//  FeatReferenceName.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/24/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

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