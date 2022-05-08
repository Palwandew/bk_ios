//
//  LoginUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

class LoginUseCase {
    private let loginRepository: LoginDomainRepoProtocol
    
    init(loginRepository: LoginRepositoryImp){
        self.loginRepository = loginRepository
    }
    
    func login(){
        loginRepository.login(with: "tehseen.absaly@gmail.com", password: "Pakistan2022^")
    }
}
