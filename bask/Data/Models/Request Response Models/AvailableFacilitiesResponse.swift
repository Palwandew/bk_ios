//
//  AvailableFacilitiesResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 14/09/2022.
//

import Foundation

// MARK: - AvailableFacilitiesResponse
struct AvailableFacilitiesResponse: Codable {
    let data: AvailableFacilitiesResponseData
    let error: Bool
    let message: String
}

// MARK: - AvailableFacilitiesResponseData
struct AvailableFacilitiesResponseData: Codable {
    let facilities: [AvailableFacility]
}

// MARK: - AvailableFacility
struct AvailableFacility: Codable {
    let id, englishName: String
    let facilityDescription: String?
    let address: String
    let price: Int
    let city: String
    let star: Double?
    
    let images: [FacilityImage]
    
    enum CodingKeys: String, CodingKey {
        case id, englishName
        case facilityDescription = "description"
        case address, price, city, star, images
    }
}

