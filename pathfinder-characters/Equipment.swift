//
//  Equipment.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/21/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class EquipmentReferenceName: Object {
    dynamic var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    func toEquipmentObject() -> Equipment {
        return DBManager.fetchEquipmentObjectFromDatabase(self.name)
    }
}

class Equipment {
    
    dynamic var name = ""
    dynamic var classification = ""
    dynamic var cost_gp = 0
    dynamic var cost_sp = 0
    dynamic var medWeight = 0.0
    
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

class Weapon: Equipment {
    var weapon_category = ""
    var damage_s = ""
    var damage_m = ""
    var crit_multiplier = 0
    var crit_roll = 0
    var range = 0
    var damage_type = [String : Bool]()
    var special = [String : Bool]()
    
    func reload() {
        let weaponObj = DBManager.fetchWeaponObjectFromDatabase(self.name)
        
        self.classification = weaponObj.name
        self.cost_gp = weaponObj.cost_gp
        self.cost_sp = weaponObj.cost_sp
        self.medWeight = weaponObj.medWeight
        self.weapon_category = weaponObj.weapon_category
        self.damage_s = weaponObj.damage_s
        self.damage_m = weaponObj.damage_m
        self.crit_multiplier = weaponObj.crit_multiplier
        self.crit_roll = weaponObj.crit_roll
        self.range = weaponObj.range
        self.damage_type = weaponObj.damage_type
        self.special = weaponObj.special
    }
    
    
    
}

class Armor: Equipment {
    
    var ac_bonus = 0
    var max_dex_bonus = 0
    var armor_check_penalty = 0
    var arcane_spell_fail_chance = 0.0
    var speed_30 = 0
    var speed_20 = 0
    
    func reload() {
        let armorObj = DBManager.fetchArmorObjectFromDatabase(self.name)
        
        self.classification = armorObj.name
        self.cost_gp = armorObj.cost_gp
        self.medWeight = armorObj.medWeight
        self.ac_bonus = armorObj.ac_bonus
        self.max_dex_bonus = armorObj.max_dex_bonus
        self.armor_check_penalty = armorObj.armor_check_penalty
        self.arcane_spell_fail_chance = armorObj.arcane_spell_fail_chance
        self.speed_30 = armorObj.speed_30
        self.speed_20 = armorObj.speed_20
    }
    
}

class Item: Equipment {
    
    
}