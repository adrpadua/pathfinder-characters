//
//  Races.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/15/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

enum Races: Int {
    
    case Dwarf, Elf, Halfling, Human
    
    static let allValues = [Dwarf, Elf, Halfling, Human]
    
    func name() -> String {
        switch self {
        case .Dwarf:
            return "Dwarf"
        case .Elf:
            return "Elf"
        case .Halfling:
            return "Halfling"
        case .Human:
            return "Human"
        }
    }
    
    func getAbilityScoreBonuses() -> [String : Int] {
        
        var racials = ["STR" : 0,
                       "DEX" : 0,
                       "CON" : 0,
                       "INT" : 0,
                       "WIS" : 0,
                       "CHA" : 0]
        switch self {
        case .Dwarf:
            racials["CON"] = 2
            racials["WIS"] = 2
            racials["CHA"] = -2
            return racials
        case .Elf:
            racials["DEX"] = 2
            racials["INT"] = 2
            racials["CON"] = -2
            return racials
        case .Halfling:
            racials["DEX"] = 2
            racials["CHA"] = 2
            racials["STR"] = -2
            return racials
        case .Human:
            return racials
        }
    }
    
    static func racesFromString(string: String) -> Races? {
        for race in self.allValues {
            if race.name() == string {
                return race
            }
        }
        return nil
    }
    
}