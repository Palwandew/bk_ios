//
//  ComplainGuestUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 19/09/2022.
//

import Foundation

class ComplainGuestUseCase {
    
    private let repository: GuestsDomainRepoProtocol
    
    init(repo: GuestsDomainRepoProtocol){
        
        self.repository = repo
    }
    
    func lodgeComplainAgainst(_ guestID: String, for bookingID: Int, with comment: String, completion: @escaping (Result<String, Error>) -> Void){
        repository.lodgeComplainAgainst(guestID, bookingID, with: comment, completion: completion)
    }
}
