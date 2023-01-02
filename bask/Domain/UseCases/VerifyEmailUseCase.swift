//
//  VerifyEmailUseCase.swift
//  bask
//
//  Created by MapMac on 02/01/2023.
//

import Foundation

class VerifyEmailUseCase {
    
    private let repo: UserRepositoryProtocol
    
    init(repo: UserRepositoryProtocol) {
        self.repo = repo
    }
    
    func verifyEmail(_ email: String) {
        
    }
}
