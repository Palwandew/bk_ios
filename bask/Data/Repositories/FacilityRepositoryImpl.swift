//
//  FacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import Foundation

class FacilityRepositoryImpl: FacilityDomainReopProtocol {
    
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyZDczMjZiLWU2ZTktNDYxNC1hYmU3LWFmZDlhMjhmNzdmNSIsImlhdCI6MTY3MDg4NjAyMiwiZXhwIjoxNjcxMzE4MDIyfQ.6SNSV1UxyZHQaQeFV8rxvCSj6t9tmVYFCZESmVp38Wg"
    var header: [String: String]? {
        ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"]
    }
    
    func publishFacility(_ facility: Facility, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.CREATE_FACILITY
        
        performNetworkCall(endpoint, facility, completion)
    }
    
    
    
    func saveFacilityUnpublished(_ facility: Facility, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.CREATE_FACILITY
        
        performNetworkCall(endpoint, facility, completion)
    }
    
    
    
    
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
    
    /// Performs a network call to create a facility on the server.
    /// - Parameters:
    ///   - endpoint: Endpoint of the request.
    ///   - facility: Facility to create in back-end.
    ///   - completion: completion handler.
    fileprivate func performNetworkCall(_ endpoint: Endpoints, _ facility: Facility, _ completion: @escaping (Result<String, Error>) -> Void) {
        URLSession.shared.dataTaskWithBody(endpoint: endpoint, requestType: .post, headers: self.header, encodeDataType: facility, decodeDataType: FacilityCreationResponse.self) { result in
            switch result {
            case .success(let responseData):
                guard let facilityID = responseData.data.facility.id else {
                    return completion(.failure(RequestError.unexpectedStatusCode))
                }
                completion(.success(facilityID))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
