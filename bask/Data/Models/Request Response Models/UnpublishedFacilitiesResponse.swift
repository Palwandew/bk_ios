//
//  UnpublishedFacilitiesResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 14/09/2022.
//

import Foundation

import Foundation

// MARK: - UnpublishedFacilitiesResponse
struct UnpublishedFacilitiesResponse: Codable {
    let data: UnpublishedFacilitiesDataClass
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct UnpublishedFacilitiesDataClass: Codable {
    let facilities: [UnpublishedFacility]
}

// MARK: - Facility
struct UnpublishedFacility: Codable {
    let id, englishName: String
    let facilityDescription, address: String?
    let price: Int?
    let progress: Int
    let images: [FacilityImage]

    enum CodingKeys: String, CodingKey {
        case id, englishName
        case facilityDescription = "description"
        case address, price, progress, images
    }
}
