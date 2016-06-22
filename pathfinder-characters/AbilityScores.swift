//
//  CharacterAbilityScores.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
import Darwin

class AbilityScore: Object {
    
    dynamic var name = ""
    dynamic var value = 10
    
    convenience init(name: String, value: Int) {
        self.init()
        self.name = name
        self.value = value
    }
    
    func increment() {
        self.value += 1
    }
}

extension AbilityScore {
    var modifier: Int {
        return (self.value - 10) / 2
    }
}