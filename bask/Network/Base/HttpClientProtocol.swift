//
//  Request.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

protocol HttpClientProtocol{
    func sendRequest<T: Codable>(
        endpoint: String,
        reqestType: RequestMethod,
        headers: [String : String]?,
        body: [String : String]?,
        responseModel: T.Type,
        completion: @escaping (Result<T, RequestError>) -> ()
    )
}

// MARK: Default Implementaion

extension HttpClientProtocol {
    
    func sendRequest<T: Codable>(
        endpoint: String,
        requestType: RequestMethod,
        headers: [String : String]?,
        body: [String : String]?,
        responseModel: T.Type,
        complete completion: @escaping (Result<T,RequestError>) -> Void) {
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            
            if let body = body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    
                    completion(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(RequestError.noResponse))
                    return
                }
                
                do {
                    let dataFromServer = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(dataFromServer))
                    
                } catch {
                    completion(.failure(RequestError.decode))
                }
                
            }.resume()
        }
}


// Need to implement this protocol


