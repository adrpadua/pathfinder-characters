//
//  Equipment.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/21/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift


class EquipmentObject {
    
    var name = ""
    var classification = ""
    var cost_gp = 0
    var cost_sp = 0
    var medWeight = 0.0
    
    var smallWeight: Double {
        get {
            return medWeight/2
        }
    }
    
    var largeWeight: Double {
        get {
            return medWeight * 2
        }
    }

}

class WeaponObject: EquipmentObject {
    var weapon_category = ""
    var damage_s = ""
    var damage_m = ""
    var crit_multiplier = 0
    var crit_roll = 0
    var range = 0
    var damage_type = [String : Bool]()
    var special = [String : Bool]()
    
}

class ArmorObject: EquipmentObject {
    
    var ac_bonus = 0
    var max_dex_bonus = 0
    var armor_check_penalty = 0
    var arcane_spell_fail_chance = 0.0
    var speed_30 = 0
    var speed_20 = 0
}

class ItemObject: EquipmentObject {
    
    
}