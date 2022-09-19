//
//  GuestsRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

class GuestsRepositoryImpl: GuestsDomainRepoProtocol {
    
    
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MzYwNzQ5NiwiZXhwIjoxNjY0MDM5NDk2fQ.jGU9lV4swFm_u17xzCdljTY3jkAQQO7hekON56x56Dc"
    
    func lodgeComplainAgainst(_ guest: String, _ bookingID: Int, with comments: String, completion: @escaping (Result<String, Error>) -> Void) {
        let _ = Endpoints.ADD_COMPLAIN
        let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
        let requestBody = ComplainRequestBody(requestBy: ownerId, defandant: guest, type: "complain", bookingID: bookingID, dueDate: Date().description, body: comments)
        
        print("Request body \(requestBody)")
        
        completion(.failure(RequestError.unknown("Error")))
        //completion(.success("Done"))
//        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: requestBody) { result in
//            switch result {
//            case .failure(let error):
//                print("error \(error.localizedDescription)")
//                completion(.failure(error))
//
//            case .success(let response):
//                completion(.success(response))
//            }
//        }

    }
    
    
    
    
    
    
    
    func getSingleRating(with id: String, completion: @escaping (Result<[Question], Error>) -> Void) {
        let queryParameters = URLQueryItem(name: "rating_info_id", value: id)
        let endPoint = Endpoints.GET_SINGLE_RATING(with: [queryParameters])
        
        //print("Endpoint \(endPoint.url?.absoluteString)")
        
        URLSession.shared.sendRequest(endpoint: endPoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: SingleGuestRatingResponse.self) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                guard let data = response.data.ratings.first else {
                    return completion(.failure(RequestError.noResponse))
                }
                
                let questions = data.rating.map{$0.dotQuestionEntity()}
                completion(.success(questions))
            }
        }
    }
    
    func updateGuestPreviousRating(_ oldRatingID: Int, _ comment: String, _ questions: [Question], completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.ADD_GUEST_RATING
        
        let requestBody = UpdatedGuestRatingRequestBody.fromDOTEntity(oldRatingID, comment, questions)
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: requestBody) { result in
            switch result {
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
    func getAllGuests<T>(_ endPoint: Endpoints, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        
        URLSession.shared.sendRequest(endpoint: endPoint, requestType: .get, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: nil, responseModel: T.self) { result in
            switch result {
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
    func rateGuest(requestBody: RateGuestRequestBody, completion: @escaping (Result<String, Error>) -> Void) {
        let endpoint = Endpoints.ADD_GUEST_RATING
        
        URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .post, headers: ["x-access-token": accessToken, "Content-Type":"application/json; charset=utf-8"], body: requestBody) { result in
            switch result {
            case .failure(let error):
                print("error \(error.localizedDescription)")
                completion(.failure(error))
                
            case .success(let response):
                completion(.success(response))
            }
        }
    }
    
    
}
