//
//  GlobalExtensions.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/22/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

let realm = RealmHandler.instance.realm

let skillNames = ["Acrobatics"
    , "Appraise"
    , "Bluff"
    , "Climb"
    , "Craft"
    , "Diplomacy"
    , "Disable Device"
    , "Disguise"
    , "Escape Artist"
    , "Fly"
    , "Handle Animal"
    , "Heal"
    , "Intimidate"
    , "Knowledge (Arcana)"
    , "Knowledge (Dungeoneering)"
    , "Knowledge (Engineering)"
    , "Knowledge (History)"
    , "Knowledge (Geography)"
    , "Knowledge (Local)"
    , "Knowledge (Nature)"
    , "Knowledge (Nobility)"
    , "Knowledge (Planes)"
    , "Knowledge (Religion)"
    , "Linguistics"
    , "Perception"
    , "Perform"
    , "Profession"
    , "Ride"
    , "Sense Motive"
    , "Sleight of Hand"
    , "Spellcraft"
    , "Stealth"
    , "Survival"
    , "Swim"
    , "Use Magic Device"]

extension List {
    func getReferenceNamed(name: String) -> T {
        
        let object = self.filter("name == %@", "\(name)")[0]
        
        return object
    }
}

extension SpecialAbilityObject {
    func isNamed(name: String) -> Bool {
        return self.name == name
    }
}

extension String {
    var isNotEmpty: Bool  {
        if self == "" {
            return false
        }
        return true
    }
}





