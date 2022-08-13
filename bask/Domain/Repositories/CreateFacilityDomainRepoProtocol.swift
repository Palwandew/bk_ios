//
//  CreateFacilityDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation


protocol CreateFacilityDomainRepoProtocol {
    
    //MARK: - Step - 1
    func addFacilityName(_ data: Data, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 2
    func updateFacilityDimensions(_ data: FacilityAreaBodyData, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 3
    func updateFacilityFreeAmenities(_ data: FacilityFreeAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
}
