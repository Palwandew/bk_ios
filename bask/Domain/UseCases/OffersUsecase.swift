//
//  OffersUsecase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

struct OffersUsecase {
    
    private let repository: OffersDomainRepoProtocol
    
    init(repo: OffersDomainRepoProtocol){
        self.repository = repo
    }
    
    func getAllOffer(completion: @escaping (Result<String, Error>) -> Void){
        repository.getOffers(completion: completion)
    }
    
    func getFacilitiesForOffer(completion: @escaping (Result<[OfferFacility], Error>) -> Void){
        
        repository.getFacilities(completion: completion)
    }
    
    func createNewOffer(with newOffer: Offer, completion: @escaping (Result<String, Error>) -> Void){
        repository.postNewOffer(newOffer, completion: completion)
    }
}
