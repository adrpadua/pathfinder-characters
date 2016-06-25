//
//  CharacterSkills.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/12/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class SkillObject: ReferenceObject {
    
    var name = ""
    var keyAbility = ""
    var short_description = ""
    var trainedOnly = false
    var armorCheckPenalty = false
    
}