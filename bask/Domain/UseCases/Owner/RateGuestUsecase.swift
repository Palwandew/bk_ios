//
//  RateGuestUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 18/09/2022.
//

import Foundation

class RateGuestUsecase {
    
    private let repository: GuestsDomainRepoProtocol
    
    init(repo: GuestsDomainRepoProtocol){
        self.repository = repo
    }
    
    func saveRating(with guest: RateGuestRequestBody, completion: @escaping (Result<String, Error>) -> Void){
        repository.rateGuest(requestBody: guest, completion: completion)
    }
    
    func getSingleRating(with id: String, completion: @escaping (Result<[Question], Error>) -> Void){
        repository.getSingleRating(with: id, completion: completion)
    }
    
    func updatePreviousRatingData(at ID: Int, with comment: String, and stars: [Question], completion: @escaping (Result<String, Error>) -> Void){
        repository.updateGuestPreviousRating(ID, comment, stars, completion: completion)
    }
}
