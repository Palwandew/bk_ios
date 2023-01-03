//
//  UserRepositoryImpl.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

class BaskUserRepo: UserRepositoryProtocol {
    
    private let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol){
        self.httpClient = httpClient
    }
    
    func checkEmailAvailability(_ email: String, completion: @escaping (Result<EmailAvailabilityModel, RequestError>) -> Void){
        let endpoint = Endpoint(path: "verify?email=\(email)")
        
        httpClient.sendRequest(endpoint: endpoint.url, reqestType: .get, authorization: nil, body: nil, responseModel: EmailAvailabilityModel.self, complete: completion)
    }
    
    func signUp(user: User, completion: @escaping (Result<ClientToken, RequestError>) -> Void) {
        
        let endpoint = Endpoint(path: "signup").url
        
        do {
            let data = try JSONEncoder().encode(user)
            httpClient.sendRequest(endpoint: endpoint, reqestType: .post, authorization: nil, body: data, responseModel: ClientToken.self, complete: completion)
            
        } catch {
            completion(.failure(.unknown(error.localizedDescription)))
        }

        
    }
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        print("Getting")
    }
    
    func verifyUserPassword(_ currentPassword: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        print("setting")
    }
    
    func updatePassword(_ newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        print("hii")
    }
    
    
}

class UserRepositoryImpl: UserRepositoryProtocol {
    
    
    
    func signUp(user : User, completion: @escaping (Result<ClientToken, RequestError>) -> Void){
        let _ = Endpoints(path: "signup")
        
    }
    
    func checkEmailAvailability(_ email: String, completion: @escaping (Result<EmailAvailabilityModel, RequestError>) -> Void) {
        print("hi")
    }
    
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
