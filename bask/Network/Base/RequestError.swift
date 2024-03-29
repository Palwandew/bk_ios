//
//  RequestError.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/05/2022.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case conflict
    case unexpectedStatusCode
    case unknown(String)
    
    var customMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid Endpoint"
        case .noResponse:
            return "No response from endpoint"
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        
        default:
            return "Unknown error"
        }
    }
}
