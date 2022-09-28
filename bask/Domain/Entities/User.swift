//
//  User.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

public struct User{
    let id: String?
    let fullName: String?
    let city: String?
    let mobileNumber: String?
    let email: String?
    
    init(id: String?, fullName: String?, city: String?, phone: String?, email: String?){
        self.id = id
        self.fullName = fullName
        self.city = city
        self.mobileNumber = phone
        self.email = email
        
    }
    
    init(){
        self.id = nil
        self.fullName = nil
        self.city = nil
        self.mobileNumber = nil
        self.email = nil
    }
    
    
}
