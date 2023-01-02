//
//  SignupUseCase.swift
//  bask
//
//  Created by MapMac on 27/12/2022.
//

import Foundation

class SignupUseCase {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func signUp(_ user: User, completion: @escaping (Result<User, RequestError>) -> Void){
        if user.isDataValid() {
            repository.signUp(user, completion: completion)
        } else {
            completion(.failure(.unknown("Invalid user data")))
        }
        
    }
    
    func verifyEmail(_ email: String, completion: @escaping (Result<EmailAvailabilityModel, RequestError>) -> Void){
        repository.checkEmailAvailability(email, completion: completion)
    }
}
