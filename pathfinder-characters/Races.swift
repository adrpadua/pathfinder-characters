//
//  Races.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/15/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

class Race {
    
    var name: String
    var size: String
    var speed: (String, Int)
    var level: Int
    var abilityScoreBonuses: [String : Int]
    var languages: [String]
    
    init () {
        self.name = ""
        self.size = ""
        self.speed = ("", 0)
        self.level = 0
        self.abilityScoreBonuses = [String : Int]()
        self.languages = [String]()
    }
}