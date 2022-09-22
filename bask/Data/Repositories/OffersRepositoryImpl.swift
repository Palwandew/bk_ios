//
//  OffersRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

class OffersRepositoryImpl: OffersDomainRepoProtocol {
    
    let accessToken = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2Mzc2NzUxNCwiZXhwIjoxNjY0MTk5NTE0fQ.HBYuwjTubmMSixou-JnmDWPQQsDX5Un7eJ1WvGn1J5c", "Content-Type":"application/json; charset=utf-8"]
    
    
    func getOffers(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("Successful"))
    }
    
    func getFacilities(completion: @escaping (Result<[OfferFacility], Error>) -> Void) {
        let endpoint = Endpoints.GET_OWNER_FACILITIES
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: accessToken, body: nil, responseModel: OwnerFacilitiesForOffersResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.data.facilities))
            }
        }
    }
    
    func postNewOffer(_ offer: Offer, completion: @escaping (Result<String, Error>) -> Void) {
        guard let requestBody = NewOfferRequestBody.fromEntity(offer) else {
            completion(.failure(RequestError.unknown("unknow")))
            return
        }
        
        let endpoint = Endpoints.OFFER
        
        print("Endpoint >>>>> \(endpoint.url?.absoluteString)")
        print("Request body >>>>> \(requestBody)")
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: accessToken, body: requestBody) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let message):
                completion(.success(message))
            }
        }
    }
    
    
}
