//
//  OwnerOffersResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 22/09/2022.
//

import Foundation

// MARK: - OwnerOffersResponse
struct OwnerOffersResponse: Codable {
    let data: OwnerOffersResponseData
    let error: Bool
    let message: String
}

// MARK: - OwnerOffersResponseData
struct OwnerOffersResponseData: Codable {
    let offers: OwnerOffers
}

// MARK: - OfOwnerOffersfers
struct OwnerOffers: Codable {
    let results: [OfferItem]
    let total: Int
}

// MARK: - OfferItem
struct OfferItem: Codable {
    let id, discount: Int
    let discountType, facilityID, englishName, address: String
    let star: Double?
    let price: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case id, discount
        case discountType = "discount_type"
        case facilityID = "facility_id"
        case englishName, address, star, price, photo
    }
}
