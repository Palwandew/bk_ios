//
//  SignUpFormModel.swift
//  bask
//
//  Created by MapMac on 21/12/2022.
//

import Foundation

struct SignUpFormModel {
    var fullName: String
    var city: String
    var email: String
    var password: String
    var phoneNumber: String
    var country: Country = Country(code: "+92", name: "Pakistan")
    var emailHelperText: EmailHelperText = .valid
    var nameHelperText: NameHelperText = .valid
    var passwordHelperText: PasswordHelperText = .valid
    var userType: UserType 
    
    
    enum EmailHelperText: String {
        case valid = "You'll need to confirm this email later."
        case empty = "Don't forget to enter your email address."
        case invalid = "This email is invalid. Make sure it's written like \n example@email.com"
        case notAvailable = "This email is already registered. Choose a different one."
    }
    
    enum NameHelperText: String {
        case valid = "This appears on your Bask profile."
        case empty = "Don't forget to enter your name."
    }
    
    enum PasswordHelperText: String {
        case valid = "Use at least 8 characters."
        case empty = "Don't forget to enter your password."
        case invalid = "Your password needs to be at least 8 characters long."
    }
    
    
    
    
}
