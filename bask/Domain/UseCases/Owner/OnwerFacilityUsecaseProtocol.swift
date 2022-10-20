//
//  OnwerFacilityUsecaseProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/10/2022.
//

import Foundation

protocol OwnerFacilityUsecaseProtocol {
    
    
    func updateFacility(with facilityID: String?, for step: FacilityCreationStep, with data: Encodable, completion: @escaping (Result<String, Error>) -> Void)
}
