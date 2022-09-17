//
//  GuestsRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

class GuestsRepositoryImpl: GuestsDomainRepoProtocol {
    
    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2MzE3NTI1NCwiZXhwIjoxNjYzNjA3MjU0fQ.c_V5hDpyIL2gWEQOQMGo6Fzw2skP_4QBIsQNhMxiiRg"
    
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
    
    
}
