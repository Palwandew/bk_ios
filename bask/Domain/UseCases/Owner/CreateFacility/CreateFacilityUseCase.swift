//
//  CreateFacilityUseCase.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation


class CreateFacilityUseCase {
    private let createFacilityRepo: CreateFacilityDomainRepoProtocol
    
    init(repository: CreateFacilityDomainRepoProtocol){
        createFacilityRepo = repository
    }
    
    func createFacility(_ endpoint: Endpoints,_ facility: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        createFacilityRepo.addFacilityName(endpoint, facility, completion: completion)
    }
    
    
    func updateFacilityArea(_ endpoint: Endpoints, with data: Encodable, completion: @escaping (Result<String, Error>) -> Void){
        let facilityAreaRequestData = data as! FacilityAreaBodyData
        
        createFacilityRepo.updateFacilityDimensions(endpoint, facilityAreaRequestData, completion: completion)
    }
    
    func updateFacility(with facilityID: String?, for step: FacilityCreationStep, with data: Encodable, completion: @escaping (Result<String, Error>) -> Void) {
        
        guard let facilityID = facilityID else {
            return completion(.failure(RequestError.unknown("FacilityID not found.")))
        }
        
        switch step {
            
        case .stepTwo:
            print("step two")
            
            
        case .stepThree:
            let stepThreeRequestData = data as! FacilityFreeAmenitiesRequestBody
            
            createFacilityRepo.updateFacilityFreeAmenities(stepThreeRequestData, completion: completion)
            
        case .stepFour:
            let stepFourRequestData = data as! FacilityPaidAmenitiesRequestBody
            createFacilityRepo.updateFacilityPaidAmenities(stepFourRequestData, completion: completion)
            
        case .stepFive:
            let stepFiveRequestData = data as! FacilityRulesRequestBody
            
            createFacilityRepo.updateFacilityRules(with: facilityID, stepFiveRequestData, completion: completion)
            
        case .stepSix:
            let stepSixRequestData = data as! FacilityLocationRequestBody
            
            createFacilityRepo.updateFacilityLocation(with: facilityID, stepSixRequestData, completion: completion)
            
        case .stepSeven:
            guard let stepSevenRequestData = data as? FacilityCheckInTimeRequestBody else {
                return
            }
            
            createFacilityRepo.updateFacilityCheckInTime(with: facilityID, stepSevenRequestData, completion: completion)
            
        case .stepEight:
            guard let stepEightRequestData = data as? FacilityPriceRequestBody else {
                return
            }
            
            createFacilityRepo.updateFacilityPrice(with: facilityID, stepEightRequestData,completion: completion)
            
        case .stepNine:
            guard let stepNineRequestData = data as? FacilityDescriptionRequestBody else {
                completion(.failure(RequestError.unknown("Unable to create request body.")))
                return
            }
            createFacilityRepo.updateFacilityDescription(with: facilityID, stepNineRequestData, completion: completion)
            
        case .stepTen:
            
            print("ten stp")
        }
        
    }
    
    func getImage(comp: @escaping (Result<Data, Error>) -> Void) {
        createFacilityRepo.getImageFromServer { result in
            switch result {
            case .success(let data):
                comp(.success(data))
            case .failure(_):
                print("fail")
            }
        }
    }
    
    func getChecklist(for facilityID: String?, completion: @escaping (Result<Checklist, Error>) -> Void) {
        
        guard let facilityID = facilityID else {
            return completion(.failure(RequestError.unknown("FacilityID not found.")))
        }

        createFacilityRepo.getChecklist(for: facilityID, completion: completion)
    }
    
    func publishFacility(with facilityID: String?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let facilityID = facilityID else {
            return completion(.failure(RequestError.unknown("FacilityID not found.")))
        }
        createFacilityRepo.publishFacility(with: facilityID, completion: completion)
    }
    
}
