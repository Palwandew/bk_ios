//
//  LoginUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

class LoginUseCase {
    private let loginRepository: LoginDomainRepoProtocol
    
    init(loginRepository: LoginDomainRepoProtocol){
        self.loginRepository = loginRepository
    }
    
    func login(completion: @escaping (User?) -> ()){
        loginRepository.login(with: "tehseen.absaly@gmail.com", password: "Pakistan2022^", completion: { (user) in
            completion(user)
        })
    }
}
