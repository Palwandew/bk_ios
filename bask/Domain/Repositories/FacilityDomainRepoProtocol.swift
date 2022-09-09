//
//  FacilityDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import Foundation

protocol FacilityDomainReopProtocol {
    
    func getFacilities(completion: @escaping (Result<[Booking], Error> ) -> Void)
}
