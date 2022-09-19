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
    
    func updateGuestPreviousRating(_ oldRatingID: Int, _ comment: String, _ questions: [Question], completion: @escaping (Result<String, Error>) -> Void)
    
    func getSingleRating(with id: String, completion: @escaping (Result<[Question], Error>) -> Void)
    
}
