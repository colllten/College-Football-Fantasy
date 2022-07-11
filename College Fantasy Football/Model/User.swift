//
//  User.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/2/22.
//

import Foundation

class User: ObservableObject {
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    
    func setEmail(email: String) {
        self.email = email
    }
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
