//
//  VerifyPasswordRequestResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 28/09/2022.
//

import Foundation

// MARK: - VerifyPasswordRequestResponse
struct VerifyPasswordRequestResponse: Codable {
    let data: VerifyPasswordRequestResponseData
    let error: Bool
    //let errorCode: Int = 200
    let message: String
}

// MARK: - VerifyPasswordRequestResponseData
struct VerifyPasswordRequestResponseData: Codable {
}
