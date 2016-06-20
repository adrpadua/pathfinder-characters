//
//  TraitList.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

/*
 CURRENT LISTS
 Feats
 AbilityScores
 Skills
 */

protocol TraitList {
    
    associatedtype ItemType: Object

    var linkedTo: LinkingObjects<PlayerCharacter> { get }
    var list: List<ItemType> { get }
    
    func getElementFromName(name: String) -> ItemType
}







class FeatsList: Object {
    
    // MARK: TraitList Protocol
    typealias ItemType = Feat
    
    let linkedTo = LinkingObjects(fromType: PlayerCharacter.self, property: "pc_feats")
    let list = List<Feat>()
    
    func getElementFromName(name: String) -> FeatsList.ItemType {
        let feat = list.filter("name == %@", "\(name)")[0]
        return feat
    }
    
    
    var parentPlayerCharacter: PlayerCharacter {
        return linkedTo.first!
    }
    
    func addFeat(featName: String) {
        let feat = DBManager.getFeatObject(featName)
        list.append(feat)
    }
}


class AbilityScoreList: Object, TraitList {
    
    // MARK: TraitList Protocol
    typealias ItemType = AbilityScore
    
    let linkedTo = LinkingObjects(fromType: PlayerCharacter.self, property: "pc_abilityScores")
    let list = List<AbilityScore>()
    
    func getElementFromName(name: String) -> AbilityScoreList.ItemType {
        let ability = list.filter("name == %@", "\(name)")[0]
        return ability
    }
    
    var parentPlayerCharacter: PlayerCharacter {
        return linkedTo.first!
    }
    
    
    
    // MARK: Custom Stuff
    
    func generateAbilityScores(scores: [Int]) {
        
        if scores.count == 6 {
            
            let names = ["STR", "DEX", "CON", "INT", "WIS", "CHA"]
            
            for index in 1...6 {
                
                // TODO: Fix this
                let abilityName = names[index - 1]
                
//                let raceBonus = Race,(abilityName)
//                
                let abilityValue = scores[index - 1]
                let abilityObj = AbilityScore(name: abilityName, value: abilityValue)
                list.append(abilityObj)
            }
            
        } else {
            print("Error setting scores")
        }
    }
    
    func modifierFromName(name: String) -> Int {
        let abilityMod = list.filter("name == %@", "\(name)")[0].modifier
        return abilityMod
    }
    
//    func getRaceBonus(abilityName: String) -> Int {
//        let pc_race = Races.racesFromString(parentPlayerCharacter.pc_race)
//        let raceBonus = pc_race!.getAbilityScoreBonuses()[abilityName]!
//        
//        return raceBonus
//    }
}
