//
//  GuestsDomainRepoProtocol.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

protocol GuestsDomainRepoProtocol {
    
    func getAllGuests<T: Codable>(_ endPoint: Endpoints, response: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    
    func rateGuest(requestBody: RateGuestRequestBody, completion: @escaping (Result<String, Error>) -> Void)
    
}
