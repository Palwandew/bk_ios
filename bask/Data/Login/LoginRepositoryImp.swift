//
//  LoginRepositoryImp.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

class LoginRepositoryImp: LoginDomainRepoProtocol{
   
    func login(with email: String, password: String, completion: @escaping (User?) -> Void) {
//        let encodedString = Data("\(email):\(password)".utf8).base64EncodedString()
//        let loginEndpoint = LoginEndpoint(path: "login", method: RequestMethod.post, header: ["Authorization": "Basic \(encodedString)", "Content-Type":"application/json; charset=utf-8"], body: ["userType" : "owner"])
        
        
//        URLSession.shared.sendRequest(endpoint: loginEndpoint.baseURL + loginEndpoint.path, requestType: loginEndpoint.method, headers: loginEndpoint.header, body: loginEndpoint.body, responseModel: UserModel.self) { result in
//            
//            switch result {
//            case .failure(let error):
//                print("ERRROR --> \(error)")
//                
//            case .success(let userModel):
//                completion(userModel.data.user.dotUserEntity())
//            }
//            
//        }
        
    }
}
