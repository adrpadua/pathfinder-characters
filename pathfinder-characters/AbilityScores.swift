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
    dynamic var modifier = 0
    
    convenience init(name: String, value: Int) {
        self.init()
        self.name = name
        self.value = value
        refreshModifier()
    }
    
    func refreshModifier() {
        modifier = value.modifier
    }
    
    override var description: String {
        get {
            return "\(name): \(value) (\(modifier))"
        }
    }

}
extension Int {
    var modifier: Int {
        return (self - 10) / 2
    }
}