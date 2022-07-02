//
//  ContentView.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/1/22.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    @Published var signedIn = false
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result,
            error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                //Successful login
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {result,
            error in
            guard result != nil, error == nil else {
                print("No success")
                return
            }
            print("Success")
            DispatchQueue.main.async {
                self.signedIn = true
            }
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
}

struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            if (viewModel.signedIn) {
                Text("You are signed in")
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @StateObject() var viewModel: AppViewModel = AppViewModel()
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                TextField("Username", text: $email)
                    .padding()
                    .background(.white)
                    .frame(width: 300, height: 50, alignment: .center)
                    .cornerRadius(10)
                    .padding(.bottom)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.white)
                    .frame(width: 300, height: 50)
                    .cornerRadius(10)
                    .padding(.bottom)
                    .padding(.bottom)
                Button("Login") {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(10)
                NavigationLink("Create Account", destination: SignUpView())
                    .frame(width: 300, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(10)
            }
            
        }
    }
}

struct SignUpView: View {

    @State var email: String = ""
    @State var password: String = ""
    @StateObject() var viewModel: AppViewModel = AppViewModel()

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
                TextField("Username", text: $email)
                    .padding()
                    .background(.white)
                    .frame(width: 300, height: 50, alignment: .center)
                    .cornerRadius(10)
                    .padding(.bottom)
                SecureField("Password", text: $password)
                    .padding()
                    .background(.white)
                    .frame(width: 300, height: 50)
                    .cornerRadius(10)
                    .padding(.bottom)
                    .padding(.bottom)
                Button("Sign Up") {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                }
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .background(.green)
                .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppViewModel())
    }
}
