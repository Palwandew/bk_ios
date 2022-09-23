//
//  OffersDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

protocol OffersDomainRepoProtocol {
    
    func getOffers(completion: @escaping (Result<[OfferItem], Error>) -> Void )
    
    func getFacilities(completion: @escaping (Result<[OfferFacility], Error>) -> Void)
    
    func postNewOffer(_ offer: Offer, completion: @escaping (Result<String, Error>) -> Void)
    
    func getOfferItemDetails(with offerID: String, and facilityID: String, completion: @escaping (Result<OfferItemDetails, Error>) -> Void)
}
