//
//  HttpClient.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

extension URLSession{
    
    func sendRequest<T: Codable>(
        endpoint: String,
        requestType: RequestMethod,
        headers: [String : String]?,
        body: Data?,//[String : String]?,
        responseModel: T.Type,
        complete completion: @escaping (Result<T, RequestError>) -> Void) {
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            
            if let body = body {
                request.httpBody = body//try? JSONSerialization.data(withJSONObject: body, options: [])
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
    
    
    func sendUpdateRequest<Value>(
        endpoint: String,
        requestType: RequestMethod,
        headers: [String : String]?,
        body: Value?,//[String : String]?,
        //responseModel: T.Type,
        complete completion: @escaping (Result<String, RequestError>) -> Void) where Value : Encodable {
            
            guard let url = URL(string: endpoint) else {
                completion(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            
            if let body = body {
                
                do {
                    let requestBody = try JSONEncoder().encode(body)
                    request.httpBody = requestBody
                } catch {
                    print("error encoding the data")
                }
                //request.httpBody = body//try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let err = error {
                    completion(.failure(RequestError.unknown(err.localizedDescription)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    let test  = response as? HTTPURLResponse
                    print("code --> \(String(describing: test?.statusCode))")
                    completion(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard data != nil else {
                    completion(.failure(RequestError.noResponse))
                    return
                }
                
                print("Data from server \(String(describing: data))")
                completion(.success("Success"))

                
            }.resume()
    }
    
}
