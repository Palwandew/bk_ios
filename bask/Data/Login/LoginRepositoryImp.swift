//
//  LoginRepositoryImp.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

class LoginRepositoryImp: LoginDomainRepoProtocol{
    
    func login(with email: String, password: String) {
        let encodedString = Data("\(email):\(password)".utf8).base64EncodedString()
        
        
        let loginEndpoint = LoginEndpoint(path: "login", method: RequestMethod.post, header: ["Authorization": "Basic \(encodedString)", "Content-Type":"application/json; charset=utf-8"], body: ["userType" : "owner"])
        
        guard let url = URL(string: loginEndpoint.path) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = loginEndpoint.header
        request.httpMethod = loginEndpoint.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
        }
        task.resume()
        
    }
}
