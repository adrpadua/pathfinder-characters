//
//  Spellcaster.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/24/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

protocol Spellcaster {
    
    var availableSpells: [SpellReferenceName] { get set }
    
    func loadAvailableSpells()
}