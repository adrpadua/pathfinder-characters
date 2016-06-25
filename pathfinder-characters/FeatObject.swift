//
//  Feats.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/14/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class FeatObject: ReferenceObject {
    
    var name = ""
    var type = ""
    var prereqs = ""
    var benefits = ""
}