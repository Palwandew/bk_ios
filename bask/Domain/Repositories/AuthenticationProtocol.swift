//
//  LoginDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

protocol AuthenticationProtocol{
    
    func login(with email: String, password: String, completion: @escaping (User?) -> Void)
    
    func signUp(user: User, completion: @escaping (Result<User,RequestError>) -> Void)
    
}
