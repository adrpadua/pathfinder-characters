//
//  Manager.swift
//  pathfinder-alpha
//
//  Created by Adrian Padua on 6/6/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import RealmSwift

class Manager {
    
    static var instance = Manager()
    
    var active_pc: PlayerCharacter?
    
    var realm: Realm
    
    var characters: Results<PlayerCharacter> {
        return realm.objects(PlayerCharacter)
    }
    
    
    init() {
        
        let URL: NSURL = NSURL(string: "file:///Users/adrpadua/xCodeProjects/pathfinder-alpha/Realm/default.realm")!
        var config = Realm.Configuration(fileURL: URL)
        config.schemaVersion = 1
        
        realm = try! Realm(configuration: config)
        
        loadCharacters()
        
        let dir = realm.configuration.fileURL!
        print(dir)
    }
    
    func createNewCharacter() {
        active_pc = PlayerCharacter()
        active_pc!.pc_name = String(NSDate().timeIntervalSince1970)
    }
    
    func saveActiveCharacter() {
        try! realm.write {
            realm.add(active_pc!)
        }
    }
    
    func loadCharacters() {
        realm.refresh()
    }
    
    func clearAllData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
