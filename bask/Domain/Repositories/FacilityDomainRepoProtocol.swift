//
//  FacilityDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import Foundation

protocol FacilityDomainReopProtocol {
    
    // This will get all the booked facilities. Need to make it generic for available and unpublished as well.
    func getFacilities(completion: @escaping (Result<[Booking], Error> ) -> Void)
    
    func getAvailableFacilities(completion: @escaping (Result<[AvailableFacility], Error>) -> Void)
    
    func getUnpublishedFacilities(completion: @escaping (Result<[UnpublishedFacility], Error>) -> Void)
    
    // This will get a single Facility
    func getFacility<T: Codable>(_ endPoint: Endpoints, response: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    
    // To get percentage cut that goes to bask
    func getBaskCutForRenting(completion: @escaping (Result<[FacilityPercentage], Error>) -> Void)
    
    
}
