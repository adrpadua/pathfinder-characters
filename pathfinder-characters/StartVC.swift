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
        
        print("Welcome. # of characters in database = \(Manager.instance.characters.count)")
        
    }
    
    @IBAction func char_1_BtnPressed(sender: UIButton) {
        Manager.instance.deActivateCurrentCharacter()
        Manager.instance.createNewCharacter()
        print("New Character created:")
        Manager.instance.saveActiveCharacter()
        print("# of characters in database = \(Manager.instance.characters.count)")
        
        if let character = Manager.instance.active_pc {
            character.setName("Largolass Largleaf")
            character.setRaceName("Elf")
            character.setClassName("Cleric")
            let scores = [15, 13, 12, 8, 9, 10]
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
        
        print(Manager.instance.active_pc!)
    }
    
    @IBAction func char_2_BtnPressed(sender: UIButton) {
        Manager.instance.deActivateCurrentCharacter()
        Manager.instance.createNewCharacter()
        print("New Character created:")
        Manager.instance.saveActiveCharacter()
        print("# of characters in database = \(Manager.instance.characters.count)")
        
        if let character = Manager.instance.active_pc {
            character.setName("Bolbo Baggins")
            character.setRaceName("Halfling")
            character.setClassName("Rogue")
            let scores = [11, 12, 6, 15, 18, 8]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.addSkillRankTo("Acrobatics")
            character.addFeat("Acrobatic")
            character.addFeat("Shatter Defenses")
            character.setMaxHitPoints()
            character.addEquipmentToInventory("Sword, short")
            character.addEquipmentToInventory("Hide")
        }
        
        print(Manager.instance.active_pc!)
    }
    
    @IBAction func clearDataBtnPressed(sender: UIButton) {
        Manager.instance.clearAllData()
        print("Character database cleared.")
        print("# of characters in database = \(Manager.instance.characters.count)")
    }

    @IBAction func spellsTest(sender: UIButton) {
        
        let _ = DBManager.fetchSpellObjectFromDatabase("Animate Dead")
        
        let _ = DBManager.fetchFeatObjectFromDatabase("Acrobatic")
        
        let _ = DBManager.fetchWeaponObjectFromDatabase("Dagger")
    }
    
    @IBAction func checkActiveCharacter(sender: UIButton) {
        print(Manager.instance.active_pc?.name)
    }
}

