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
        complete completion: @escaping (Result<T, RequestError>) -> Void)
}



