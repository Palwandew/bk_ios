//
//  ImageLinkRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/08/2022.
//

import Foundation

// MARK: - ImageLinkRequestBody
struct ImageLinkRequestBody: Codable {
    let facilityID, photo: String
    let isPrimary: Bool

    enum CodingKeys: String, CodingKey {
        case facilityID = "facilityId"
        case photo, isPrimary
    }
}
