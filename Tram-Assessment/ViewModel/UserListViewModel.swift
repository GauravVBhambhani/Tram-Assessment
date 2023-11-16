//
//  UserListViewModel.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation

class UserListViewModel : ObservableObject {
    @Published var userArray = [User]()
    
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadDataFromSQLiteDatabase() {
        userArray = SQLiteQueries.presentRows() ?? []
    }
    
    func updateUserDetails(user: User) {
        if let index = userArray.firstIndex(where: { $0.id == user.id }) {
            // Update the user in the array
            userArray[index] = user
        }
    }
    //    func numberOfRowsInSection (section: Int) -> Int {
    //        if userArray.count != 0 {
    //            return userArray.count
    //        }
    //        return 0
    //    }
}
