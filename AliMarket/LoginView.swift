//
//  LoginView.swift
//  AliMarket
//
//  Created by Nima on 6/8/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var username: String = "a@b.com"
    @State private var password: String = "123456"
    @State private var isSuccessfullLogin = false
    @State private var isLoading = false
    @State private var isAlertShow = false
    var body: some View {
        NavigationView {
            Form {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                Section {
                    TextField("Username...", text: $username)
                    SecureField("Password...", text: $password)
                }
                
                ZStack {
                    HStack {
                        Spacer()
                        if !isLoading {
                            Button("Sign in", action: {
                                login()
                            })
                            .buttonStyle(.borderedProminent)
                        }
                        Spacer()
                    }
                    if isLoading {
                        ProgressView()
                    }
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isSuccessfullLogin) {
                    EmptyView()
                }
            )
            .alert("Login Error", isPresented: $isAlertShow) {
                
            } message: {
                Text("Please check username and password...")
            }
        }
    }
    
    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            isLoading = false
            guard error != nil else {
                isSuccessfullLogin = true
                return
            }
            isAlertShow = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
