//
//  HttpClient.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import Foundation

class HttpClient: HttpClientProtocol {
    func sendRequest<T>(endpoint: URL?, requestType: RequestMethod, authorization: String?, complete completion: @escaping (Result<T.Type, RequestError>) -> Void) where T : Equatable {
        
        
        guard let url = endpoint else {
            return completion(.failure(RequestError.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(RequestError.unknown("error in http client")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 401:
                        return completion(.failure(.unauthorized))
                    case 409:
                        return completion(.failure(.conflict))
                    default:
                        return completion(.failure(.unexpectedStatusCode))
                    }
                }
                return completion(.failure(.unexpectedStatusCode))
            }
            
            guard let _ = data else {
                completion(.failure(RequestError.noResponse))
                return
            }
            completion(.success(T.self))
        }
        task.resume()
        
    }
    
    
    
    
    
    func sendRequest<T>(endpoint: URL?, reqestType: RequestMethod, authorization: String?, body: Data? , responseModel: T.Type, complete completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let url = endpoint else {
            return completion(.failure(RequestError.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = reqestType.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(RequestError.unknown("error in http client")))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 401:
                        return completion(.failure(.unauthorized))
                    default:
                        return completion(.failure(.unexpectedStatusCode))
                    }
                }
                return completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(RequestError.noResponse))
                return
            }
            
            do {
                let dataFromServer = try JSONDecoder().decode(T.self, from: data)
                print(String(data: data, encoding: .utf8) ?? "unable to print pretty json")
                completion(.success(dataFromServer))
                
            } catch {
                completion(.failure(RequestError.decode))
            }
        }
        task.resume()
    }
}

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
                    //print("data from server \(dataFromServer)")
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
    
    
    func dataTaskWithBody<Value, T: Codable>(
        endpoint: Endpoints,
        requestType: RequestMethod,
        headers: [String: String]?,
        encodeDataType: Value?,
        decodeDataType: T.Type,
        completionHandler: @escaping (Result<T, RequestError>) -> Void) where Value: Encodable {
            guard let url = endpoint.url else {
                completionHandler(.failure(RequestError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            
            request.httpMethod = requestType.rawValue
            request.allHTTPHeaderFields = headers
            
            if let body = encodeDataType {
                
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let requestBody = try encoder.encode(body)
                    print(String(data: requestBody, encoding: .utf8) ?? "unable to print pretty json")
                    request.httpBody = requestBody
                } catch {
                    print("error encoding the data")
                }
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let err = error {
                    completionHandler(.failure(RequestError.unknown(err.localizedDescription)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    let test  = response as? HTTPURLResponse
                    print("code --> \(String(describing: test?.statusCode))")
                    completionHandler(.failure(RequestError.unexpectedStatusCode))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(RequestError.noResponse))
                    return
                }
                do {
                    let dataFromServer = try JSONDecoder().decode(T.self, from: data)
                    //print("data from server \(dataFromServer)")
                    completionHandler(.success(dataFromServer))
                    
                } catch {
                    print("decode error")
                    completionHandler(.failure(RequestError.decode))
                }
                
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
                    if let resultString = String(data: requestBody, encoding: .utf8) {
                        print(resultString)
                    }
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



