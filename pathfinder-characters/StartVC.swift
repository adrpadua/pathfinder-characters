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
            character.setRace("Elf")
            character.setClass("Cleric")
            let scores = [15, 13, 12, 8, 9, 10]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.modifySkill("Climb", byAmount: 1)
            character.modifySkill("Perception", byAmount: 1)
            character.modifySkill("Acrobatics", byAmount: 1)
            print(character.pc_skills?.getElementFromName("Acrobatics").total)
            character.setEmptyFeatsList()
            character.addFeat("Alignment Channel")
            character.addFeat("Penetrating Strike")
            character.setMaxHitPoints()
            character.setSavingThrows()
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
            character.setRace("Halfling")
            character.setClass("Rogue")
            let scores = [11, 12, 6, 15, 18, 8]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.modifySkill("Disguise", byAmount: 1)
            character.modifySkill("Use Magic Device", byAmount: 1)
            character.modifySkill("Knowledge (Local)", byAmount: 1)
            character.setEmptyFeatsList()
            character.addFeat("Acrobatic")
            character.addFeat("Shatter Defenses")
            character.setMaxHitPoints()
            character.setSavingThrows()
        }
        
        print(Manager.instance.active_pc!)
    }
    
    @IBAction func clearDataBtnPressed(sender: UIButton) {
        Manager.instance.clearAllData()
        print("Character database cleared.")
        print("# of characters in database = \(Manager.instance.characters.count)")
    }

    @IBAction func spellsTest(sender: UIButton) {
        
        let _ = DBManager.getSpellObject("Animate Dead")
        
        let _ = DBManager.getFeatObject("Acrobatic")
        
        
    }
    
}

