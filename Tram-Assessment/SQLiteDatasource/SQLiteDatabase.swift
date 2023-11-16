//
//  SQLiteDatabase.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation
import SQLite

class SQLiteDatabase {
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        // Create database connection
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("usersList").appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
            
        }
        
        catch {
            print("Creating connection to database error: \(error)")
        }
    }
    
    // Create table
    func createTable() {
        SQLiteQueries.createTable()
    }
}
