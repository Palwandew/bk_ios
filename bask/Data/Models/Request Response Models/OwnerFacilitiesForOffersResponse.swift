//
//  OwnerFacilitiesForOffersResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

// MARK: - OwnerFacilitiesForOffersResponse
struct OwnerFacilitiesForOffersResponse: Codable {
    let data: OwnerFacilitiesForOffersData
    let error: Bool
    let message: String
}

// MARK: - OwnerFacilitiesForOffersData
struct OwnerFacilitiesForOffersData: Codable {
    let facilities: [OfferFacility]
}

// MARK: - OfferFacility
struct OfferFacility: Codable {
    let englishName: String
    let address: String?
    let price: Int?
    let id: String
}
