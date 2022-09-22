//
//  OffersDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

protocol OffersDomainRepoProtocol {
    
    func getOffers(completion: @escaping (Result<String, Error>) -> Void )
    
    func getFacilities(completion: @escaping (Result<[OfferFacility], Error>) -> Void)
    
    func postNewOffer(_ offer: Offer, completion: @escaping (Result<String, Error>) -> Void)
}
