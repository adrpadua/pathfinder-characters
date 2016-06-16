//
//  Classes.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import Darwin

enum Classes: String {
    
    case Cleric, Fighter, Rogue, Wizard
    
    static let allValues = [Cleric, Fighter, Rogue, Wizard]
    
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
    
    func startingGold() -> Int {
        
        switch self {
        case .Cleric:
            return 140
        case .Fighter:
            return 175
        case .Rogue:
            return 140
        case .Wizard:
            return 70
        }
    }
    
    func baseSavingThrows(level: Int) -> [String : Int] {
    
        var savingThrows: [String : Int]
        
        switch self {
        case .Cleric:
            savingThrows = ["Fort" : 2 + Int(floor(Double(level / 2))),
                            "Ref" : 0 + Int(floor(Double(level / 3))),
                            "Will" : 2 + Int(floor(Double(level / 2))),]
        case .Fighter:
            savingThrows = ["Fort" : 2 + Int(floor(Double(level / 2))),
                            "Ref" : 0 + Int(floor(Double(level / 3))),
                            "Will" : 0 + Int(floor(Double(level / 3))),]
        case .Rogue:
            savingThrows = ["Fort" : 0 + Int(floor(Double(level / 3))),
                            "Ref" : 2 + Int(floor(Double(level / 2))),
                            "Will" : 0 + Int(floor(Double(level / 3))),]
        case .Wizard:
            savingThrows = ["Fort" : 0 + Int(floor(Double(level / 3))),
                            "Ref" : 0 + Int(floor(Double(level / 3))),
                            "Will" : 2 + Int(floor(Double(level / 2))),]
        }
        
        return savingThrows
    }
    
    static func classesFromString(string: String) -> Classes? {
        for aClass in self.allValues {
            if aClass.name() == string {
                return aClass
            }
        }
        return nil
    }
}

