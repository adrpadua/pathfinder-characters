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
        // Do any additional setup after loading the view, typically from a nib.
        print("Welcome. # of characters in database = \(Manager.instance.characters.count)")
        
    }
    
    @IBAction func startBtnPressed(sender: UIButton) {
        Manager.instance.createNewCharacter()
        print("New Character created:")
        print(Manager.instance.active_pc)
        Manager.instance.saveActiveCharacter()
        print("# of characters in database = \(Manager.instance.characters.count)")
    }
    @IBAction func loadBtnPressed(sender: UIButton) {
        Manager.instance.createNewCharacter()
        print("New Character created:")
        Manager.instance.saveActiveCharacter()
        print("# of characters in database = \(Manager.instance.characters.count)")
        
        if let character = Manager.instance.active_pc {
            character.setRace("Halfling")
            character.setClass("Rogue")
            let scores = [10, 12, 14, 16, 18, 20]
            character.setAbilityScores(scores)
            character.setBaseSkills()
            character.modifySkill("Disguise", byAmount: 1)
            character.setEmptyFeatsList()
            character.addFeat("Acrobatic")
            character.addFeat("Shatter Defenses")
        }
        
        print(Manager.instance.active_pc!)
    }
    
    @IBAction func JSONBtnPressed(sender: UIButton) {
        
    }
    
    @IBAction func clearDataBtnPressed(sender: UIButton) {
        Manager.instance.clearAllData()
        print("Character database cleared.")
        print("# of characters in database = \(Manager.instance.characters.count)")
    }

    
}

