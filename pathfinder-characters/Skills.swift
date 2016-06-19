//
//  CharacterSkills.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

let numSkills = 35

enum Skills: Int {
    
    case Acrobatics = 1, Appraise, Bluff, Climb, Craft, Diplomacy, DisableDevice, Disguise, EscapeArtist, Fly, HandleAnimal, Heal, Intimidate, KnowledgeArcana, KnowledgeDungeoneering, KnowledgeEngineering, KnowledgeHistory, KnowledgeGeography, KnowledgeLocal, KnowledgeNature, KnowledgeNobility, KnowledgePlanes, KnowledgeReligion, Linguistics, Perception, Perform, Profession, Ride, SenseMotive, SleightOfHand, Spellcraft, Stealth, Survival, Swim, UseMagicDevice
    
    static let allValues = [Acrobatics, Appraise, Bluff, Climb, Craft, Diplomacy, DisableDevice, Disguise, EscapeArtist, Fly, HandleAnimal, Heal, Intimidate, KnowledgeArcana, KnowledgeDungeoneering, KnowledgeEngineering, KnowledgeHistory, KnowledgeGeography, KnowledgeLocal, KnowledgeNature, KnowledgeNobility, KnowledgePlanes, KnowledgeReligion, Linguistics, Perception, Perform, Profession, Ride, SenseMotive, SleightOfHand, Spellcraft, Stealth, Survival, Swim, UseMagicDevice]
    
    func name() -> String {
        switch self {
        case .Acrobatics:
            return "Acrobatics"
        case .Appraise:
            return "Appraise"
        case .Bluff:
            return "Bluff"
        case .Climb:
            return "Climb"
        case .Craft:
            return "Craft"
        case .Diplomacy:
            return "Diplomacy"
        case .DisableDevice:
            return "Disable Device"
        case .Disguise:
            return "Disguise"
        case .EscapeArtist:
            return "Escape Artist"
        case .Fly:
            return "Fly"
        case .HandleAnimal:
            return "Handle Animal"
        case .Heal:
            return "Heal"
        case .Intimidate:
            return "Intimidate"
        case .KnowledgeArcana:
            return "Knowledge (Arcana)"
        case .KnowledgeDungeoneering:
            return "Knowledge (Dungeoneering)"
        case .KnowledgeEngineering:
            return "Knowledge (Engineering)"
        case .KnowledgeHistory:
            return "Knowledge (History)"
        case .KnowledgeGeography:
            return "Knowledge (Geography)"
        case .KnowledgeLocal:
            return "Knowledge (Local)"
        case .KnowledgeNature:
            return "Knowledge (Nature)"
        case .KnowledgeNobility:
            return "Knowledge (Nobility)"
        case .KnowledgePlanes:
            return "Knowledge (Planes)"
        case .KnowledgeReligion:
            return "Knowledge (Religion)"
        case .Linguistics:
            return "Linguistics"
        case .Perception:
            return "Perception"
        case .Perform:
            return "Perform"
        case .Profession:
            return "Profession"
        case .Ride:
            return "Ride"
        case .SenseMotive:
            return "Sense Motive"
        case .SleightOfHand:
            return "Sleight of Hand"
        case .Spellcraft:
            return "Spellcraft"
        case .Stealth:
            return "Stealth"
        case .Survival:
            return "Survival"
        case .Swim:
            return "Swim"
        case .UseMagicDevice:
            return "Use Magic Device"
        }
    }
    
    func keyAbility() -> Ability {
        switch self {
        case .Acrobatics:
            return Ability.DEX
        case .Appraise:
            return Ability.INT
        case .Bluff:
            return Ability.CHA
        case .Climb:
            return Ability.STR
        case .Craft:
            return Ability.INT
        case .Diplomacy:
            return Ability.CHA
        case .DisableDevice:
            return Ability.DEX
        case .Disguise:
            return Ability.CHA
        case .EscapeArtist:
            return Ability.DEX
        case .Fly:
            return Ability.DEX
        case .HandleAnimal:
            return Ability.CHA
        case .Heal:
            return Ability.WIS
        case .Intimidate:
            return Ability.CHA
        case .KnowledgeArcana:
            return Ability.INT
        case .KnowledgeDungeoneering:
            return Ability.INT
        case .KnowledgeEngineering:
            return Ability.INT
        case .KnowledgeHistory:
            return Ability.INT
        case .KnowledgeGeography:
            return Ability.INT
        case .KnowledgeLocal:
            return Ability.INT
        case .KnowledgeNature:
            return Ability.INT
        case .KnowledgeNobility:
            return Ability.INT
        case .KnowledgePlanes:
            return Ability.INT
        case .KnowledgeReligion:
            return Ability.INT
        case .Linguistics:
            return Ability.INT
        case .Perception:
            return Ability.WIS
        case .Perform:
            return Ability.CHA
        case .Profession:
            return Ability.WIS
        case .Ride:
            return Ability.DEX
        case .SenseMotive:
            return Ability.WIS
        case .SleightOfHand:
            return Ability.DEX
        case .Spellcraft:
            return Ability.INT
        case .Stealth:
            return Ability.DEX
        case .Survival:
            return Ability.WIS
        case .Swim:
            return Ability.STR
        case .UseMagicDevice:
            return Ability.CHA
        }
    }
    
    
    static func skillsFromString(string: String) -> Skills? {
        for skill in self.allValues {
            if skill.name() == string {
                return skill
            }
        }
        return nil
    }
}

class Skill: Object {
    
    
    // REALM-PERSISTED ITEMS
    let partOfList = LinkingObjects(fromType: SkillList.self, property: "list")
    dynamic var name = ""
    dynamic var keyAbility = ""
    dynamic var classSkillBonus = 0
    dynamic var baseValue = 0
    dynamic var ranks = 0
    
    convenience init(name: String, ranks: Int, ability: Ability) {
        self.init()
        self.name = name
        self.ranks = ranks
        self.keyAbility = ability.name()
    }
    
    
    // OTHER STUFF
    
    var parentPlayerCharacter: PlayerCharacter {
        get {
            return (partOfList.first!.parentPlayerCharacter!)
        }
    }
    
    var total: Int {
        get {
            return baseValue + classSkillBonus + ranks
        }
    }
    
    func addRanks(num: Int) {
        ranks += num
    }
    
    func isClassSkill() -> Bool {
        let classObj = classObjFromString(parentPlayerCharacter.pc_class, level: parentPlayerCharacter.pc_level)
        for classSkill in (classObj!.classSkills) {
            if classSkill == self.name {
                return true
            }
        }
        return false
    }
}