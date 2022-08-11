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
            let test = data as! FacilityAreaBodyData
            
            //print("hee haa \(test.capacity)")
            createFacilityRepo.updateFacilityDimensions(test) { result in
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
