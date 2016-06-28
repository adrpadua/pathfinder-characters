//
//  SpecialAbilities.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/28/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation

enum SpecialAblityTags: String {
    case Elf, Human, Halfling, Gnome
    case Cleric
    case Feat
}

class SpecialAbilityObject {
    var name = ""
    var type = ""
    var tag = ""
    var description = ""
}

