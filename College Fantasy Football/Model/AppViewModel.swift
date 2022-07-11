//
//  AppViewModel.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/2/22.
//

import Foundation
import FirebaseAuth

class AppViewModel: ObservableObject {

    @Published var signedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    
    var isSignedIn: Bool {
        if (Auth.auth().currentUser != nil) {
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            signedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
            UserDefaults.standard.set(Auth.auth().currentUser?.email, forKey: "userEmail")
            return UserDefaults.standard.bool(forKey: "isSignedIn")
        } else {
            UserDefaults.standard.set(false, forKey: "isSignedIn")
            return false
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: "isSignedIn")
                UserDefaults.standard.set(Auth.auth().currentUser?.email, forKey: "userEmail")
                self.signedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: "isSignedIn")
                UserDefaults.standard.set(self.fetchEmail, forKey: "userEmail")
                self.signedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        signedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    }
    
    func fetchEmail() -> String {
        return Auth.auth().currentUser?.email ?? "N/A"
    }
}
