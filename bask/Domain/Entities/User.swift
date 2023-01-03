//
//  User.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation
 
struct User: Codable{
    let id: String?
    var fullName: String
    var email: String
    var password: String
    var phoneNumber: String?
    
    init(id: String? = nil, fullName: String, email: String, password: String, phoneNumber: String? = nil) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
    }
    
    func isDataValid() -> Bool {
        if fullName.isEmpty || email.isEmpty || password.isEmpty {
            return false
        } else {
            return true
        }
    }
    
}
