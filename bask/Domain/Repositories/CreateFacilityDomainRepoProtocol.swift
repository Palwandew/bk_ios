//
//  CreateFacilityDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation


protocol CreateFacilityDomainRepoProtocol {


    
    //MARK: - Step - 1
    func addFacilityName(_ endpoint: Endpoints, _ data: Data, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 2
    func updateFacilityDimensions(_ endpoint: Endpoints, _ data: FacilityAreaBodyData, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 3
    func updateFacilityFreeAmenities(_ data: FacilityFreeAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 4
    func updateFacilityPaidAmenities(_ data: FacilityPaidAmenitiesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 5
    func updateFacilityRules(with facilityID: String, _ data: FacilityRulesRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 6
    func updateFacilityLocation(with facilityID: String, _ data: FacilityLocationRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    
    //MARK: - Step - 7
    func updateFacilityCheckInTime(with facilityID: String, _ data: FacilityCheckInTimeRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 8
    func updateFacilityPrice(with facilityID: String, _ data: FacilityPriceRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 9
    func updateFacilityDescription(with facilityID: String, _ data: FacilityDescriptionRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
    //MARK: - Step - 10
    func getImageFromServer(completion: @escaping (Result<Data, Error>) -> Void)
    
    //MARK: - Step -10-A
    func getChecklist(for facilityID: String, completion: @escaping (Result<Checklist, Error>) -> Void)
    
    
    //MARK: - Step - 11
    func publishFacility(with facilityID: String, completion: @escaping (Result<String, Error>) -> Void)
}
