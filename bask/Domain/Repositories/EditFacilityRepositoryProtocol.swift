//
//  EditFacilityRepositoryProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/10/2022.
//

import Foundation

protocol EditFacilityRepositoryProtocol {
    
    func getRoomsData(completion: @escaping (Result<Facility, Error>) -> Void)
    
    
}
