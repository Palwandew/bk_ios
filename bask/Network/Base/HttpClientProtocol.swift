//
//  Request.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

protocol HttpClientProtocol{
    func sendRequest<T: Codable>(
        endpoint: URL?,
        reqestType: RequestMethod,
        authorization: String?,
        body: Data?,
        responseModel: T.Type,
        complete completion: @escaping (Result<T, RequestError>) -> Void)
    
    func sendRequest<T>(
        endpoint: URL?,
        requestType: RequestMethod,
        authorization: String?,
        complete completion: @escaping (Result<T.Type, RequestError>) -> Void) where T : Equatable
    
}

enum Authorization: String {
    case bearer = "Bearer"
    case basic = "Basic"
}

