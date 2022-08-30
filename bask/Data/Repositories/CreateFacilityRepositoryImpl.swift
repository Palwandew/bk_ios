//
//  CreateFacilityRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation

class CreateFacilityReopositoryImpl: CreateFacilityDomainRepoProtocol {
    
    // Don't forget to change access-token
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MTcxNDc3MiwiZXhwIjoxNjYyMTQ2NzcyfQ.qEOoXez7INgPyf6yjTi_rJZM-CJc5ZB12UNT4da6DYk"
    
    let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
    
    func addFacilityName(_ data: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        let url = "https://api.baskapp.co/api/v1/facility"
        
        URLSession.shared.sendRequest(endpoint: url, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data, responseModel: FacilityCreateName.self) { result in
            switch result {
            case .failure(let error):
                print("error occured \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response.data.facility.id))
                
            }
            
        }
    }
    
    
    func updateFacilityDimensions(_ data: FacilityAreaBodyData, completion: @escaping (Result<String, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        print("url -> \(url)")
        
        
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result{
            case .success(_):
                completion(.success("Success"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityFreeAmenities(_ data: FacilityFreeAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://api.baskapp.co/api/v1/facilityservice/amenitiesfree"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityPaidAmenities(_ data: FacilityPaidAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://api.baskapp.co/api/v1/facilityservice/amenitiesextra"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func updateFacilityRules(_ data: FacilityRulesRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityLocation(_ data: FacilityLocationRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityCheckInTime(_ data: FacilityCheckInTimeRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityPrice(_ data: FacilityPriceRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
            switch result {
                
            case .success(let success):
                completion(.success(success))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateFacilityDescription(_ data: FacilityDescriptionRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/\(facilityID)"
        
        URLSession.shared.sendUpdateRequest(endpoint: url, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: data) { result in
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
    
    func getChecklist(completion: @escaping (Result<Checklist, Error>) -> Void) {
        let facilityID = "879605bb-766e-43bf-9e08-04900a7734eb"
        let url = "https://api.baskapp.co/api/v1/facility/checklist/\(facilityID)"
        URLSession.shared.sendRequest(endpoint: url, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: FacilityChecklistModel.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let facilityChecklistModel):
                completion(.success(facilityChecklistModel.dotCheclistEntity()))
            }
        }
    }
    
    func publishFacility(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("Ad published."))
    }
}
