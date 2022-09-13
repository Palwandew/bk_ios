//
//  FacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import Foundation

class FacilityRepositoryImpl: FacilityDomainReopProtocol {
    
    
    
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2Mjc0MTYyOSwiZXhwIjoxNjYzMTczNjI5fQ.WyVE8NBrhSwwpn7ZCHWgms9jMXcVtRQk8y3QAZ7V-uA"
    
    func getFacilities(completion: @escaping (Result<[Booking], Error> ) -> Void) {
        
        let endpoint = Endpoints.GET_BOOKED_FACILITIES
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: BookedFacilitiesResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.data.bookings))
            }
        }
    }
    
    func getFacility<T: Codable>(_ endpoint: Endpoints, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: T.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}
