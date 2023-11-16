//
//  UpdateUserViewModel.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI

class UpdateUserViewModel: ObservableObject {
    @Published var user: User
    var userListViewModel: UserListViewModel  // Add this property

    init(user: User, userListViewModel: UserListViewModel) {
        self.user = user
        self.userListViewModel = userListViewModel
    }

    func updateUserDetails(
        firstName: String,
        lastName: String,
        email: String,
        phone: String,
        photo: UIImage?
    ) {
        // Update user details based on changes
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.phone = phone

        // Update photo if provided
        if let updatedPhoto = photo {
            user.picture = updatedPhoto.pngData() ?? Data()
        }

        // Save changes to the database
        saveUserChanges()
        
        // Optionally, refresh the data in the view model
        userListViewModel.loadDataFromSQLiteDatabase()
    }


    private func saveUserChanges() {
        let updateResult = SQLiteQueries.updateUser(user)

        if updateResult {
            // Notify UserListViewModel to update the data
            userListViewModel.updateUserDetails(user: user)

            // Optionally, perform any additional actions after a successful update
            print("User details updated successfully!")
        } else {
            print("Failed to update user details.")
        }
    }
}
