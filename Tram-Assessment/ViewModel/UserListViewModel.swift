//
//  UserListViewModel.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation

class UserListViewModel {
    private var userArray = [User]()
    
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadDataFromSQLiteDatabase() {
        userArray = SQLiteQueries.presentRows() ?? []
    }
    
//    func numberOfRowsInSection (section: Int) -> Int {
//        if userArray.count != 0 {
//            return userArray.count
//        }
//        return 0
//    }
}
