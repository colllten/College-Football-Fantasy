//
//  AppViewModel.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/2/22.
//

import Foundation
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.signedIn = false
    }
}
