//
//  FacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import Foundation

class FacilityRepositoryImpl: FacilityDomainReopProtocol {
    
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NTM5MzcwOCwiZXhwIjoxNjY1ODI1NzA4fQ.Azv1UgM4yfLgcrGNA0JXrGlcGGBRShvUYt5bg9jh3aU"
    
    func getBaskCutForRenting(completion: @escaping (Result<[FacilityPercentage], Error>) -> Void) {
        
        
        let endpoint = Endpoints.GET_FACILITY_PERCENTAGES
        
        let session = URLSession.init(configuration: .default)
        session.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: OwnerFacilitiesPercentageResponse.self) { result in
            switch result {
                
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.facilityPercentages()))
            }
        }
    }
    
    
    
    
    
    
    
    
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
    
    func getAvailableFacilities(completion: @escaping (Result<[AvailableFacility], Error>) -> Void) {
        
        let endpoint = Endpoints.GET_AVAILABLE_FACILITIES
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: AvailableFacilitiesResponse.self) { result in
            switch result {
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.data.facilities))
            }
        }
    }
    
    func getUnpublishedFacilities(completion: @escaping (Result<[UnpublishedFacility], Error>) -> Void) {
        
        
        let dummyFacility = UnpublishedFacility(id: "01", englishName: "Cafe de Hunza", facilityDescription: "Situated in Karimabad", address: "Karimabad Hunza", price: 20, progress: 30, images: [FacilityImage(photo: "dummyUrl")])
        
        completion(.success([dummyFacility]))
        
        //let endpoint = Endpoints.GET_UNPUBLISHED_FACILITIES
        
//        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: UnpublishedFacilitiesResponse.self) { result in
//            switch result {
//            case .failure(let error):
//                print("error \(error.localizedDescription)")
//                completion(.failure(error))
//
//            case .success(let response):
//                completion(.success(response.data.facilities))
//            }
//        }
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
