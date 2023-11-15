//
//  UserListView.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var vm: UserListViewModel = UserListViewModel()
    
    @State private var isCreatingNewUser = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.userArray){ user in
                    NavigationLink {
                        Text("User 1")
                    } label: {
                        HStack {
                            if let userImage = UIImage(data: user.picture) {
                                Image(uiImage: userImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment: .leading) {
                                Text("\(user.firstName) \(user.lastName)").font(.title2)
                                Text("\(user.phone)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteRow)
            }
            .navigationTitle("TRAM Global")
            .navigationBarItems(trailing: Button(action: {
                isCreatingNewUser = true
            }) {
                Image(systemName: "plus")
            })
            .background(
                NavigationLink(
                    destination: NewUserView(),
                    isActive: $isCreatingNewUser
                ) {
                    EmptyView()
                }
            )
            .onAppear {
                // Reload data when the view appears
                vm.loadDataFromSQLiteDatabase()
            }
        }
    }
    
    private func deleteRow(at offsets: IndexSet) {
        
        guard let firstIndex = offsets.first, firstIndex < vm.userArray.count else {
            return
        }
        
        let userIdToDelete = vm.userArray[firstIndex].id
        
        SQLiteQueries.deleteRow(userId: userIdToDelete)
        
        vm.loadDataFromSQLiteDatabase()
    }
}

#Preview {
    UserListView()
}
