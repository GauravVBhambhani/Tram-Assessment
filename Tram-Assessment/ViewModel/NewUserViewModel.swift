//
//  NewUserViewModel.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation
import SwiftUI


class NewUserViewModel {
    
    private var userValues: User?
    
    let id: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let phone: String?
    let picture: UIImage?
    
    init(userValues: User?) {
        self.userValues = userValues
        
        self.id = userValues?.id
        self.firstName = userValues?.firstName
        self.lastName = userValues?.lastName
        self.email = userValues?.email
        self.phone = userValues?.phone
        self.picture = UIImage(data: userValues!.picture)
    }
}
