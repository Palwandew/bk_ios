//
//  User.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

public struct User{
    var id: String?
    let fullName: String
    var city: String?
    let mobileNumber: String?
    let email: String
    let password: String
    let type: UserType
    var loggedIn: Bool
    var signUpWith: String
    var country: String
    
    init(fullName: String, email: String, password: String, type: UserType) {
        self.id = nil
        self.fullName = fullName
        self.city = nil
        self.mobileNumber = nil
        self.email = email
        self.password = password
        self.type = type
        self.loggedIn = false
        self.signUpWith = "email"
        self.country = "Saudi Arabia"
    }
    
    func isDataValid() -> Bool {
        if fullName.isEmpty || email.isEmpty || password.isEmpty {
            return false
        } else {
            return true
        }
    }
    
}
