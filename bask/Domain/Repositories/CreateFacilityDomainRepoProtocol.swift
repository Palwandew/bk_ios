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
    
    
    //MARK: - Step - 4
    func updateFacilityPaidAmenities(_ data: FacilityPaidAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 5
    func updateFacilityRules(_ data: FacilityRulesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 6
    func updateFacilityLocation(_ data: FacilityLocationRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 7
    func updateFacilityCheckInTime(_ data: FacilityCheckInTimeRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 8
    func updateFacilityPrice(_ data: FacilityPriceRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 9
    func updateFacilityDescription(_ data: FacilityDescriptionRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 10
    func getImageFromServer(completion: @escaping (Result<Data, Error>) -> Void)
}
