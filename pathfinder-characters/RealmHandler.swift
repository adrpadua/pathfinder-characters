//
//  Manager.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/6/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHandler {
    
    static var instance = RealmHandler()
    
    var active_pc: CharacterSheet?
    
    var realm: Realm
    
    var characters: Results<CharacterSheet> {
        return realm.objects(CharacterSheet)
    }
    
    
    init() {
        
        let URL: NSURL = NSURL(string: "file:///Users/adrpadua/Desktop/pathfinder-characters/Realm/default.realm")!
        var config = Realm.Configuration(fileURL: URL)
        config.deleteRealmIfMigrationNeeded = true
        
        realm = try! Realm(configuration: config)
        
        loadCharacters()
        
        let dir = realm.configuration.fileURL!
        print(dir)
    }
    
    func createNewCharacter() {
        active_pc = CharacterSheet()
    }
    
    func saveActiveCharacter() {
        try! realm.write {
            realm.add(active_pc!)
        }
    }
    
    func deActivateCurrentCharacter() {
        if active_pc != nil {
            saveActiveCharacter()
        }
        active_pc = nil
    }
    
    func loadCharacters() {
        realm.refresh()
    }
    
    func clearAllData() {
        try! realm.write {
            realm.deleteAll()
            active_pc = nil
        }
    }
    
}
