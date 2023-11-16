//
//  UpdateUserView.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

//
//  UpdateUserView.swift
//  Tram-Assessment
//
//  Created by Gaurav Bhambhani on 11/15/23.
//

import SwiftUI
import PhotosUI

struct UpdateUserView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var photo: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var phone: String
    
    var viewModel: UpdateUserViewModel
    
    init(viewModel: UpdateUserViewModel) {
        self.viewModel = viewModel
        // Initialize the state variables with the existing user details
        _firstName = State(initialValue: viewModel.user.firstName)
        _lastName = State(initialValue: viewModel.user.lastName)
        _email = State(initialValue: viewModel.user.email)
        _phone = State(initialValue: viewModel.user.phone)
        _photo = State(initialValue: UIImage(data: viewModel.user.picture))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                    
                    Button("Save") {
                        viewModel.updateUserDetails(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            phone: phone,
                            photo: photo
                        )
                        
                        // Optionally, dismiss the view after saving
                        dismiss()
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
                
                // Convert data of photosPickerItem into UIImage
                .onChange(of: photosPickerItem) { _, _ in
                    Task {
                        if let photosPickerItem,
                           let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                photo = image
                            }
                        }
                    }
                }
            }
            .navigationTitle("Update User")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UpdateUserView(viewModel: UpdateUserViewModel(user: User(id: 1, picture: Data(), firstName: "John", lastName: "Doe", email: "john.doe@example.com", phone: "1234567890"), userListViewModel: UserListViewModel()))
}
