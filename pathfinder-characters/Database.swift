//
//  Database.swift
//  pathfinder-characters
//
//  Created by Adrian Padua on 6/17/16.
//  Copyright © 2016 Adrian Padua. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol Database {
    
    static var fileName: String { get set }
    static var path: String { get set }
    static var jsonData: NSData { get set }
    static var database: JSON { get set }
    static var count: Int { get set }
    
}

extension Database {
    
    static func indexOf(name: String) -> Int {
        for index in 1...self.database.count {
            if name == self.database["\(index)", "name"].stringValue {
                return index
            }
        }
        return -1
    }
    
    static func getJSONDirectoryOf(elementName: String) -> JSON {
        let index = indexOf(elementName)
        let json = database["\(index)"]
        
        return json
    }
    
    
}


























