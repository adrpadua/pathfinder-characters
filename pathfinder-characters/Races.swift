//
//  Races.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/15/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

enum Size: String {
    case Tiny, Small, Medium, Large, Huge, Gargantuan
}

enum Speed: String {
    case Slow, SlowSteady, Normal
}

protocol Race {
    
    var name: String { get }
    var size: Size { get }
    var speed: Speed { get }
    var startingLanguages: [String] { get }
    var abilityScoreBonuses: [String : Int] { get set }
    
}

class Dwarf: Race {
    
    let name = "Dwarf"
    let size = Size.Medium
    let speed = Speed.SlowSteady
    let startingLanguages = ["Common", "Dwarven"]
    var abilityScoreBonuses = ["STR" : 0,
                               "DEX" : 0,
                               "CON" : 2,
                               "INT" : 0,
                               "WIS" : 2,
                               "CHA" : -2]
}

class Elf: Race {
    
    let name = "Elf"
    let size = Size.Medium
    let speed = Speed.Normal
    let startingLanguages = ["Common", "Elven"]
    var abilityScoreBonuses = ["STR" : 0,
                               "DEX" : 2,
                               "CON" : -2,
                               "INT" : 2,
                               "WIS" : 0,
                               "CHA" : 0]
}

class Halfling: Race {
    
    let name = "Halfling"
    let size = Size.Small
    let speed = Speed.Slow
    let startingLanguages = ["Common", "Halfling"]
    var abilityScoreBonuses = ["STR" : -2,
                               "DEX" : 2,
                               "CON" : 0,
                               "INT" : 0,
                               "WIS" : 0,
                               "CHA" : 2]
}

class Human: Race {
    
    let name = "Human"
    let size = Size.Medium
    let speed = Speed.Normal
    let startingLanguages = ["Common"]
    var abilityScoreBonuses = ["STR" : 0,
                               "DEX" : 0,
                               "CON" : 0,
                               "INT" : 0,
                               "WIS" : 0,
                               "CHA" : 0]
    
    // HUMAN EXCLUSIVE
    func setBonusAbilityScore(name: String) {
        abilityScoreBonuses[name]! += 2
    }
    
    
}
/*
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
*/

