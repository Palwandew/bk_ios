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
    
//    func login(completion: @escaping (User?) -> ()){
//        loginRepository.login(with: "tehseen.absaly@gmail.com", password: "Pakistan2022^", completion: { (user) in
//            completion(user)
//        })
//    }
    
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
}
