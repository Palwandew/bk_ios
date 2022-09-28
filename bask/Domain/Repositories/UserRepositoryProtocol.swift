//
//  UserRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

protocol UserRepositoryProtocol {
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void)
    
    func verifyUserPassword(_ currentPassword: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
    func updatePassword(_ newPassword: String, completion: @escaping (Result<String, Error>) -> Void)
}
