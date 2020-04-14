//
//  RealmExtensions.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 11/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//
 
import Foundation
import RealmSwift

extension Realm {
    
    static var currentSchemaVersion : UInt64 = 0
    
    public static func configureRealmMigration() {

        var config = Realm.Configuration(
            schemaVersion: currentSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                print("CurrentSchemaVersion:\(currentSchemaVersion) - OldSchemaVersion:\(oldSchemaVersion)")                
        })
 
        print("SchemaVersion: \(String(describing: config.schemaVersion)), RealmFile->\(String(describing: config.fileURL))")
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config 
    }
      
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if self.isInWriteTransaction {
            try block()
        } else {
            try self.write(block)
        }
    }

}
