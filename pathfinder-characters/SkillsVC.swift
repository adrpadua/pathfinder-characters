//
//  SkillsVC.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/11/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import UIKit

class SkillsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func setSkillsBtnPressed(sender: UIButton) {
        
        if let character = Manager.instance.active_pc {
            character.setBaseSkills()
            character.modifySkill("Use Magic Device", byAmount: 1)
        }
        
        print(Manager.instance.active_pc!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
