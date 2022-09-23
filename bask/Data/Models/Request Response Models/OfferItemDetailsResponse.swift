//
//  OfferItemDetailsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import Foundation

// MARK: - OfferItemDetailResponse
struct OfferItemDetailResponse: Codable {
    let data: OfferItemDetailData
    let error: Bool
    let message: String
}

// MARK: - OfferItemDetailData
struct OfferItemDetailData: Codable {
    let offerItem: OfferItemDetails

    enum CodingKeys: String, CodingKey {
        case offerItem = "booked_item"
    }
}

// MARK: - OfferItem
struct OfferItemDetails: Codable {
    let price: Int
    let bookedItemDescription, englishName, checkInAfter, address: String
    let length, width: Int
    let latitude, longitude: Double
    let capacity: Int
    let owner: Owner
    let cancellationpolicy: CancellationPolicy?
    let offer: [OfferDiscount]
    let images: [FacilityImage]
    let facilityservices: [JSONAny]
    let noOfLivingrooms: String
    let reviews: Reviews

    enum CodingKeys: String, CodingKey {
        case price
        case bookedItemDescription = "description"
        case englishName
        case checkInAfter = "check_in_after"
        case address, length, width, latitude, longitude, capacity, owner, cancellationpolicy, offer, images, facilityservices
        case noOfLivingrooms = "no_of_livingrooms"
        case reviews
    }
}


// MARK: - OfferDiscount
struct OfferDiscount: Codable {
    let discount: Int
}
