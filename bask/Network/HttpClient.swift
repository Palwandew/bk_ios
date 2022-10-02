//
//  HttpClient.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

extension URLSession{
    
    func sendRequest<T: Codable>(
        endpoint: Endpoints,
        requestType: RequestMethod,
        headers: [String : String]?,
        body: Data?,//[String : String]?,
        responseModel: T.Type,
        complete completion: @escaping (Result<T, RequestError>) -> Void) {
            
            guard let url = endpoint.url else {
                return completion(.failure(RequestError.invalidURL))
            }
            print("URL -_-_-_: \(url.absoluteString)")
            var request = URLRequest(url: url)
            
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            //request.cachePolicy = .reloadRevalidatingCacheData //Use cache data if the origin source can validate it; otherwise, load from the origin.
            
            if let body = body {
                request.httpBody = body//try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let er = error {
                    print("Err -> \(er)")
                    completion(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    let re = response as? HTTPURLResponse
                    print("Statu \(String(describing: re?.statusCode))")
                    completion(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(RequestError.noResponse))
                    return
                }
                
                do {
                    let dataFromServer = try JSONDecoder().decode(T.self, from: data)
                    print("data from server \(dataFromServer)")
                    completion(.success(dataFromServer))
                    
                } catch {
                    print("decode error")
                    completion(.failure(RequestError.decode))
                }
                
            }.resume()
    }
    
    func deleteRequest(endpoint: Endpoints,
                       headers: [String : String]?,
                       complete completion: @escaping (Result<String, RequestError>) -> Void){
        
        guard let url = endpoint.url else {
            return completion(.failure(RequestError.invalidURL))
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headers
        //request.cachePolicy = .reloadRevalidatingCacheData //Use cache data if the origin source can validate it; otherwise, load from the origin.
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let er = error {
                print("Err -> \(er)")
                completion(.failure(RequestError.unexpectedStatusCode))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                let re = response as? HTTPURLResponse
                print("Status \(String(describing: re?.statusCode))")
                completion(.failure(RequestError.unexpectedStatusCode))
                return
            }
            
            guard let _ = data else {
                completion(.failure(RequestError.noResponse))
                return
            }
            
            completion(.success("Successfully deleted."))
            
        }.resume()

    }
    
    
    func sendUpdateRequest<Value>(
        endpoint: Endpoints,
        requestType: RequestMethod,
        headers: [String : String]?,
        body: Value?,//[String : String]?,
        //responseModel: T.Type,
        complete completion: @escaping (Result<String, RequestError>) -> Void) where Value : Encodable {
            
            guard let url = endpoint.url else {
                completion(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            
            if let body = body {
                
                do {
                    let requestBody = try JSONEncoder().encode(body)
                    print("boy ==\(requestBody)")
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
                completion(.success("Successful."))
//                do {
//                    let requestBody = try JSONDecoder().decode(Test.self, from: data!)
//                    print("res ==\(requestBody)")
//                } catch {
//                    print("error encoding the data")
//                }
//                print("Data from server \(String(describing: data))")
//                completion(.success("Successful."))

                
            }.resume()
    }
    
}


struct Test: Codable {
    let data: TestDataClass
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct TestDataClass: Codable {
    let ratinginfo: TestRatinginfo
}

// MARK: - Ratinginfo
struct TestRatinginfo: Codable {
    let author, ratedObject: String
    let bookingID: Int
    let ratinginfoDescription: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case author
        case ratedObject = "rated_object"
        case bookingID = "booking_id"
        case ratinginfoDescription = "description"
        case id
    }
}



