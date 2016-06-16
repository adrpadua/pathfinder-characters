//
//  Classes.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

enum Classes: String {
    
    case Cleric, Fighter, Rogue, Wizard
    
    func name() -> String {
        return self.rawValue
    }
    
    func skillRanksPerLevel() -> Int { // + INT Modifier
        switch self {
        case .Cleric:
            return 2
        case .Fighter:
            return 2
        case .Rogue:
            return 8
        case .Wizard:
            return 2
        }
    }
    
    func isSpellcaster() -> Bool {
        
        switch self {
        case .Cleric:
            return true
        case .Fighter:
            return false
        case .Rogue:
            return false
        case .Wizard:
            return true
        }
    }
    
    func hitDie() -> Int {
        
        switch self {
        case .Cleric:
            return 8
        case .Fighter:
            return 10
        case .Rogue:
            return 8
        case .Wizard:
            return 6
        }
    }
}

