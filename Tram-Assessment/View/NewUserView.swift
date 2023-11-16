//
//  NewUserView.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI
import PhotosUI

struct NewUserView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var photo: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    // For alert notifications
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var viewModel: NewUserViewModel!
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                //                Color.black
                //                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    VStack {
                        PhotosPicker(selection: $photosPickerItem) {
                            Image(uiImage: (photo ?? UIImage(systemName: "person.circle"))!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                        }
                        Text("Edit")
                    }
                    
                    
                    Spacer()
                    
                    VStack {
                        TextField("Email", text: $email)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(lineWidth: 0.5)
                                    .foregroundColor(.gray)
                            )
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.top, 10)
                        
                        TextField("Mobile Number", text: $phone)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(lineWidth: 0.5)
                                    .foregroundColor(.gray)
                            )
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.top, 10)
                        
                        HStack {
                            
                            TextField("First Name", text: $firstName)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundColor(.gray)
                                )
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.top, 10)
                            
                            TextField("Last Name", text: $lastName)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(lineWidth: 0.5)
                                        .foregroundColor(.gray)
                                )
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.top, 10)
                        }
                    }
                    
                    Spacer()
                    
                    Button("Submit") {
                        
                        let id: Int = 0
                        let firstName = firstName
                        let lastName = lastName
                        let email = email
                        let phone = phone
                        let photo = photo
                        guard let picture = photo?.pngData() else {return}
                        
                        let userValues = User(id: id, picture: picture, firstName: firstName, lastName: lastName, email: email, phone: phone)
                        //                        dismiss()
                        
                        createNewUser(userValues)
                        
                        SQLiteQueries.presentRows()
                    }
                    .disabled(email.isEmpty || phone.isEmpty || firstName.isEmpty || lastName.isEmpty)
                    .frame(maxWidth: 360, maxHeight: 50)
                    .background(
                        Group {
                            if email.isEmpty || phone.isEmpty || firstName.isEmpty || lastName.isEmpty {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.gray)
                            } else {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                            }
                        }
                    )
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(50)
                    .padding(.top)
                    
                    Spacer()
                }
                // convert data of photospickeritem into uiimage
                .onChange(of: photosPickerItem) { _, _ in
                    Task {
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self){
                            
                            if let image = UIImage(data: data) {
                                photo = image
                            }
                        }
                    }
                }
            }
            
            .navigationTitle("New User")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                createTable()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    private func createTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    private func createNewUser(_ userValues: User) {
        let userAddedToTable = SQLiteQueries.insertRow(userValues)
        
        if userAddedToTable == true {
//            alertTitle = "Success"
//            alertMessage = "User added to SQLite successfully!"
//            showAlert = true
            dismiss()
        } else {
            // print("Error: user already exists")
            alertTitle = "Error"
            alertMessage = "User already exists"
            showAlert = true
        }
    }
}

#Preview {
    NewUserView()
}




