//
//  LoginView.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/2/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                HomeView()
            } else {
                LoginView()
            }
        }.onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        VStack {
            Image(systemName: "person.badge.key.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
            
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                
                Button {
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text("Sign In")
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
                
                NavigationLink("Create Account") {
                    SignUpView()
                }
                .frame(width: 200, height: 50, alignment: .center)
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(8)
                
            }
            .padding()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Sign In")
    }
}

struct SignUpView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    
    var body: some View {
        VStack {
            Image(systemName: "person.badge.key.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150, alignment: .center)
                .padding()
            
            VStack {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom)
                
                Button {
                    viewModel.signUp(email: email, password: password)
                } label: {
                    Text("Create Account")
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                }
            }
            .padding()
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Account Creation")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(email: "", password: "")
    }
}
