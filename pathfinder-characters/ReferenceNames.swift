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




