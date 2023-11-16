//
//  UserMode.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation

struct User: Identifiable {
    var id: Int
    var picture: Data
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
}

