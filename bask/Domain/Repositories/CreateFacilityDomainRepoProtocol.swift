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
    func addFacilityRooms(_ data: Data, completion: @escaping (Bool) -> Void)
}
