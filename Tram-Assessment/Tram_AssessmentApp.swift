//
//  Tram_AssessmentApp.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI

@main
struct Tram_AssessmentApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
    }
    
        init() {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                print("Path to SQLite file: \(documentsDirectory.path)")
            }
        }
}
