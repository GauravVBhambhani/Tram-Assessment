//
//  SQLiteCommands.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation
import SQLite
import SQLite3

class SQLiteQueries {
    
    static var table = Table("users")
    
    static let id = Expression<Int>("id")
    static let picture = Expression<Data>("picture")
    static let firstName = Expression<String>("firstName")
    static let lastName = Expression<String>("lastName")
    static let phone = Expression<String>("phone")
    
    static func createTable() {
        
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(phone, unique: true)
                table.column(picture)
            })
        } catch {
            print("Table already exists: \(error)")
        }
        
    }
    
    // Insert row
    static func insertRow(_ userValues: User) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            try database.run(table.insert(
                firstName <- userValues.firstName,
                lastName <- userValues.lastName,
                phone <- userValues.phone,
                picture <- userValues.picture))
            
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    
    // present rows
    
    
}
