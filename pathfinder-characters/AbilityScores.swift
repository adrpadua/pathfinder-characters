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

enum Ability: Int {
    
    case STR = 1, DEX, CON, INT, WIS, CHA
    
    func name() -> String {
        switch self {
        case .STR:
            return "STR"
        case .DEX:
            return "DEX"
        case .CON:
            return "CON"
        case .INT:
            return "INT"
        case .WIS:
            return "WIS"
        case .CHA:
            return "CHA"
        }
    }
}

/*
class AbilityScoreList: Object {
    
    dynamic var parentPlayerCharacter: PlayerCharacter?
    
    let abilityScores = List<AbilityScore>()
    
    func findSkillWithName(name: String) -> AbilityScore {
        let ability = abilityScores.filter("name == %@", "\(name)")[0]
        return ability
    }
    
    func generateAbilityScores(scores: [Int]) {
        
        if scores.count == 6 {
            
            for index in 1...6 {
                
                let pc_race = Races.racesFromString(parentPlayerCharacter!.pc_race)
                
                let abilityName = Ability(rawValue:  index)?.name()
                let raceBonus = pc_race!.getAbilityScoreBonuses()[abilityName!]!
                let abilityValue = scores[index - 1] + raceBonus
                let abilityObj = AbilityScore(name: abilityName!, value: abilityValue)
                abilityScores.append(abilityObj)
            }
            
        } else {
            print("Error setting scores")
        }
    }
    
    func getAbilityFromName(name: String) -> AbilityScore {
        let abilityScore = abilityScores.filter("name == %@", "\(name)")[0]
        return abilityScore
    }
    
    func getModifierFromName(name: String) -> Int {
        let abilityMod = abilityScores.filter("name == %@", "\(name)")[0].modifier
        return abilityMod
    }
}
 */

class AbilityScore: Object {
    
    let partOfList = LinkingObjects(fromType: AbilityScoreList.self, property: "list")
    
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