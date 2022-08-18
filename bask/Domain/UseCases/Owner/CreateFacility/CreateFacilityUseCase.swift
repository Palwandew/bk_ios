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
    
    func createFacility(_ facility: Data, completion: @escaping (Result<String, Error>) -> Void) {
        
        completion(.success("dummyId"))
        //        createFacilityRepo.addFacilityName(facility) { result in
        //            switch result {
        //            case .success(let facilityID):
        //                completion(.success(facilityID))
        //
        //            case .failure(let error):
        //                completion(.failure(error))
        //            }
        //        }
    }
    
    
    func updateFacility(for step: FacilityCreationStep, with data: Encodable, completion: @escaping (Result<String, Error>) -> Void) {
        
        switch step {
            
        case .stepTwo:
            //let test = data as! FacilityAreaBodyData
            
            //print("hee haa \(test.capacity)")
            //            createFacilityRepo.updateFacilityDimensions(test) { result in
            //                switch result {
            //                case .success(let message):
            //                    completion(.success(message))
            //                case .failure(let error):
            //                    completion(.failure(error))
            //                }
            //            }
            completion(.success("step two"))
            
        case .stepThree:
            //            let stepThreeRequestData = data as! FacilityFreeAmenitiesRequestBody
            //
            //            createFacilityRepo.updateFacilityFreeAmenities(stepThreeRequestData) { result in
            //                switch result {
            //                case .success(let message):
            //                    completion(.success(message))
            //                case .failure(let error):
            //                    completion(.failure(error))
            //                }
            //            }
            completion(.success("step three"))
        case .stepFour:
            //            let stepFourRequestData = data as! FacilityPaidAmenitiesRequestBody
            //            print("\(stepFourRequestData.facilityservices)")
            //            createFacilityRepo.updateFacilityPaidAmenities(stepFourRequestData) { result in
            //                switch result {
            //                case .success(let message):
            //                    completion(.success(message))
            //                case .failure(let error):
            //                    completion(.failure(error))
            //                }
            //            }
            completion(.success("step four"))
            
        case .stepFive:
            let stepFiveRequestData = data as! FacilityRulesRequestBody
            
            createFacilityRepo.updateFacilityRules(stepFiveRequestData) { result in
                switch result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .stepSix:
            let stepSixRequestData = data as! FacilityLocationRequestBody
            
            createFacilityRepo.updateFacilityLocation(stepSixRequestData) { result in
                switch result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .stepSeven:
            guard let stepSevenRequestData = data as? FacilityCheckInTimeRequestBody else {
                return
            }
            
            createFacilityRepo.updateFacilityCheckInTime(stepSevenRequestData) { result in
                switch result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .stepEight:
            guard let stepEightRequestData = data as? FacilityPriceRequestBody else {
                return
            }
            
            createFacilityRepo.updateFacilityPrice(stepEightRequestData) { result in
                switch result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .stepNine:
            guard let stepNineRequestData = data as? FacilityDescriptionRequestBody else {
                print("error downcasting to Description body")
                return
            }
            createFacilityRepo.updateFacilityDescription(stepNineRequestData) { result in
                switch result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        }
    }
}
