//
//  GetUserProfileDetailsUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

class GetUserProfileDetailsUsecase {
    
    private let repository: UserRepositoryProtocol
    
    init(repo: UserRepositoryProtocol){
        self.repository = repo
    }
    
    func getUserProfileDetails(completion: @escaping (Result<User, Error>) -> Void){
        
        repository.getUser(completion: completion)
    }
    
    func verifyPassword( _ password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        repository.verifyUserPassword(password, completion: completion)
    }
    
    func updatePassword(_ newPassword: String, completion: @escaping (Result<String, Error>) -> Void){
        repository.updatePassword(newPassword, completion: completion)
    }
}
