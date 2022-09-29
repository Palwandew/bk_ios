//
//  UserRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

class UserRepositoryImpl: UserRepositoryProtocol {
    
    let header = ["x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhZTI2N2U4LTY1Y2MtNGM2ZC05NDhhLTU1MThhOGJmZWIzNiIsImlhdCI6MTY2NDE2MjQ1MywiZXhwIjoxNjY0NTk0NDUzfQ.fyPMLalXuhJIdQc8--1VzUgrpUlJfAzoNIJyomopV_4", "Content-Type":"application/json; charset=utf-8"]
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        let userID = "c7ad21b6-3ca7-414e-a1d0-1f88f598d3c2"
        let endpoint = Endpoints(path: "user/\(userID)")
        URLSession.shared.sendRequest(endpoint: endpoint, requestType: .get, headers: header, body: nil, responseModel: GetUserProfileResponse.self) { result  in
            switch result {
                
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response.data.user.dotUserEntity()))
            }
        }
    }
    
    func verifyUserPassword(_ currentPassword: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let endpoint = Endpoints(path: "user/verify")
        do {
            let data = try PasswordData(password: currentPassword).encodeToJSON()
            
            URLSession.shared.sendRequest(endpoint: endpoint, requestType: .post, headers: header, body: data, responseModel: VerifyPasswordRequestResponse.self) { result in
                switch result {
                    
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    completion(.success(!response.error))
                }
            }

        } catch {
            completion(.failure(RequestError.unknown("Could not encode the password data")))
        }
        
    }
    
    func updatePassword(_ newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let userID = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
        
        let endpoint = Endpoints(path: "user/\(userID)")
        
        
            let requestBody = PasswordData(password: newPassword)
            
            URLSession.shared.sendUpdateRequest(endpoint: endpoint, requestType: .patch, headers: header, body: requestBody) { result in
                switch result {
                    
                case .failure(let error):
                    completion(.failure(error))
                case .success(let response):
                    completion(.success(response))
                }
            }
    }
    
    
    private struct PasswordData: Codable {
        let password: String
        
        func encodeToJSON() throws -> Data{
            do {
                let data = try JSONEncoder().encode(self)
                
                return data
            } catch {
                print("error encoding the data")
                throw RequestError.unknown("Couldn't encode the password data")
            }
        }
    }
}