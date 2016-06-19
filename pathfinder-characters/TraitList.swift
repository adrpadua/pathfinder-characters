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



class SkillList: Object, TraitList {
    
    // MARK: TraitList Protocol
    typealias ItemType = Skill
    
    dynamic var parentPlayerCharacter: PlayerCharacter?
    let list = List<Skill>()
    
    func getElementFromName(name: String) -> SkillList.ItemType {
        let skill = list.filter("name == %@", "\(name)")[0]
        return skill
    }
    
    
    // MARK: Custom Stuff
    dynamic var numRanks = 0
    
    func generateBaseSkillList() {
        for index in 1...numSkills {
            let skillName = Skills(rawValue: index)?.name()
            let keyAbility = Skills(rawValue: index)?.keyAbility()
            
            // Get AbilityScore from parent PC
            let charAbility = parentPlayerCharacter!.pc_abilityScores!.getElementFromName(keyAbility!.name())
            
            addSkill(skillName!, ranks: 0, ability: keyAbility!, charAbilMod: charAbility.modifier)
        }
    }
    
    func addSkill(name: String, ranks: Int, ability: Ability, charAbilMod: Int) {
        
        let skill = Skill(name: name, ranks: ranks, ability: ability)
        skill.baseValue = charAbilMod
        skill.refreshTotal()
        list.append(skill)
        numRanks += ranks
        
    }
    
    func modifySkill(skillName: String, amountToModify: Int, isClassSkill: Bool) {
        
        let skill = getElementFromName(skillName)
        
        if isClassSkill {
            skill.classSkillBonus = 3
        }
        
        skill.addRanks(amountToModify)
        skill.refreshTotal()
    }
    
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