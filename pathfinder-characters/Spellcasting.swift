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
    
    init() {
        self.name = ""
        self.school = ""
        self.classLevels = [String : Int]()
        self.short_description = ""
    }
}
