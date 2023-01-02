//
//  AuthenticationHelper.swift
//  bask
//
//  Created by MapMac on 26/12/2022.
//

import Foundation

class AuthenticationHelper {
    static let shared: AuthenticationHelper = AuthenticationHelper()
    
    var signedIn: Bool = false 
    
    private init(){}
    
    
}
