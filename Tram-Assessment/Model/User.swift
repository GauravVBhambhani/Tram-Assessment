//
//  UserMode.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import Foundation

struct User: Identifiable {
    let id: Int
    let picture: Data
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
}
