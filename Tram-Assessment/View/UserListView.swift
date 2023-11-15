//
//  UserListView.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI

struct UserListView: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self){ user in
                    NavigationLink {
                        Text("User 1")
                    } label: {
                        HStack {
                            Image(systemName: "person.circle")
                            
                            VStack(alignment: .leading) {
                                Text("User 1").font(.title2)
                                Text("User 1")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("TRAM Global")
        }
    }
}

#Preview {
    UserListView()
}
