//
//  TraitList.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

protocol TraitList {
    
    associatedtype ItemType: Object

    var parentPlayerCharacter: PlayerCharacter? { get set }
    var list: List<ItemType> { get }
    
    func getElementFromName(name: String) -> ItemType
}






class AbilityScoreList: Object, TraitList {
    
    // MARK: TraitList Protocol
    typealias ItemType = AbilityScore
    
    dynamic var parentPlayerCharacter: PlayerCharacter?
    let list = List<AbilityScore>()
    
    func getElementFromName(name: String) -> AbilityScoreList.ItemType {
        let ability = list.filter("name == %@", "\(name)")[0]
        return ability
    }
    
    // MARK: Custom Stuff
    
    func generateAbilityScores(scores: [Int]) {
        
        if scores.count == 6 {
            
            for index in 1...6 {
                
                let abilityName = Ability(rawValue:  index)?.name()
                let raceBonus = getRaceBonus(abilityName!)
                let abilityValue = scores[index - 1] + raceBonus
                let abilityObj = AbilityScore(name: abilityName!, value: abilityValue)
                list.append(abilityObj)
            }
            
        } else {
            print("Error setting scores")
        }
    }
    
    func getModifierFromName(name: String) -> Int {
        let abilityMod = list.filter("name == %@", "\(name)")[0].modifier
        return abilityMod
    }
    
    func getRaceBonus(abilityName: String) -> Int {
        let pc_race = Races.racesFromString(parentPlayerCharacter!.pc_race)
        let raceBonus = pc_race!.getAbilityScoreBonuses()[abilityName]!
        
        return raceBonus
    }
}