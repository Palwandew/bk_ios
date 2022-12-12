//
//  CreateFacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation

class CreateFacilityReopositoryImpl: CreateFacilityDomainRepoProtocol {
    func publishFacility(_ facility: Facility, completion: @escaping (Result<String, Error>) -> Void) {
        print("Hi")
    }
    
    
    // Don't forget to change access-token
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MjAyMDU5OCwiZXhwIjoxNjYyNDUyNTk4fQ.6LuD4G3ieJoFSxhLcOYFj28X47z3s0knDdYEPFLNpDM"
    
    let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
    
    func addFacilityName(_ endpoint: Endpoints, _ data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data, responseModel: FacilityCreateName.self) { result in
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.data.facility.id))
                
            }
            
        }
    }
    
    
    func updateFacilityDimensions(_ endpoint: Endpoints, _ data: FacilityAreaBodyData, completion: @escaping (Result<String, Error>) -> Void) {
        
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result{
            case .success(_):
                completion(.success("Success"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityFreeAmenities(_ data: FacilityFreeAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.ADD_FREE_AMENITIES
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityPaidAmenities(_ data: FacilityPaidAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.ADD_PAID_AMENITIES
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func updateFacilityRules(with facilityID: String, _ data: FacilityRulesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityLocation(with facilityID: String, _ data: FacilityLocationRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityCheckInTime(with facilityID: String, _ data: FacilityCheckInTimeRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityPrice(with facilityID: String, _ data: FacilityPriceRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityDescription(with facilityID: String, _ data: FacilityDescriptionRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImageFromServer(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://iosacademy.io/assets/images/courses/tiktok.png") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            completion(.success(data))
        }
        task.resume()
    }
    
    func getChecklist(for facilityID: String, completion: @escaping (Result<Checklist, Error>) -> Void) {
        let endpoint = Endpoints.GET_CHECKLIST(for: facilityID)
        
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: FacilityChecklistModel.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let facilityChecklistModel):
                completion(.success(facilityChecklistModel.dotCheclistEntity()))
            }
        }
    }
    
    func publishFacility(with facilityID: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let endpoint = Endpoints.UPDATE_FACILITY(facilityID)
        let requestBody = FacilityPublishRequestBody(status: "published")
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: requestBody) { result in
            switch result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
