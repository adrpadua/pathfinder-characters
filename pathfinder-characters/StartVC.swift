//
//  ViewController.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/2/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import UIKit

class StartVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Welcome. # of characters in database = \(RealmHandler.instance.characters.count)")
        
    }
    
    @IBAction func char_1_BtnPressed(sender: UIButton) {
        RealmHandler.instance.deActivateCurrentCharacter()
        RealmHandler.instance.createNewCharacter()
        print("New Character created:")
        RealmHandler.instance.saveActiveCharacter()
        print("# of characters in database = \(RealmHandler.instance.characters.count)")
        
        if let character = RealmHandler.instance.active_pc {
            character.setName("Largolass Largleaf")
            character.setRaceName("Elf")
            character.setLevel(5)
            character.setClassName("Cleric")
            let scores = [15, 13, 12, 3, 9, 19]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.addSkillRankTo("Climb")
            character.addSkillRankTo("Perception")
            character.addSkillRankTo("Knowledge (Arcana)")
            character.addFeat("Alignment Channel")
            character.addFeat("Penetrating Strike")
            character.setMaxHitPoints()
            character.addEquipmentToInventory("Dagger")
            
        }
        
    }
    
    @IBAction func char_2_BtnPressed(sender: UIButton) {
        RealmHandler.instance.deActivateCurrentCharacter()
        RealmHandler.instance.createNewCharacter()
        print("New Character created:")
        RealmHandler.instance.saveActiveCharacter()
        print("# of characters in database = \(RealmHandler.instance.characters.count)")
        
        if let character = RealmHandler.instance.active_pc {
            character.setName("Bolbo Baggins")
            character.setRaceName("Halfling")
            character.setClassName("Fighter")
            let scores = [11, 12, 6, 15, 18, 8]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.addSkillRankTo("Acrobatics")
            character.addFeat("Acrobatic")
            character.addFeat("Shatter Defenses")
            character.setMaxHitPoints()
            character.addEquipmentToInventory("Sword, short")
            character.addEquipmentToInventory("Hide")
            
            print(character._feats.getReferenceNamed("Shatter Defenses").toObject())
        }
    }
    
    @IBAction func clearDataBtnPressed(sender: UIButton) {
        RealmHandler.instance.clearAllData()
        print("Character database cleared.")
        print("# of characters in database = \(RealmHandler.instance.characters.count)")
    }
    
    @IBAction func spellsTest(sender: UIButton) {
        
        let airDomain = DBManager.fetchDomainObjectFromDatabase("Air")
        
        let clericObj = Cleric(domain1: airDomain, domain2: airDomain)
        clericObj.loadAvailableSpells()
        
        let abilities = DBManager.fetchClassAbilitiesArrayFromDatabase("Cleric", level: 5)
        
        for specAbility in abilities {
            print(specAbility.name)
            print(specAbility.tag)
            print(specAbility.description)
            print("")
        }
        
        let racials = DBManager.fetchRacialAbilitiesFromDatabase("Elf")
        
        for racialAbility in racials {
            print(racialAbility.name)
            print(racialAbility.tag)
            print(racialAbility.description)
            print("")
        }
        
    }
    
    @IBAction func checkActiveCharacter(sender: UIButton) {
        print(RealmHandler.instance.active_pc?.name)
    }
}

