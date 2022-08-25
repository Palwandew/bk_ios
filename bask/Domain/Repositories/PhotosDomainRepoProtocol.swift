//
//  PhotosDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/08/2022.
//

import Foundation

protocol PhotosDomainRepoProtocol {
    
    func uploadPhoto(of facilityID: String, from path: URL, progress: @escaping (Double) -> Void, completion: @escaping (Result<String, Error>) -> Void)
    
}
