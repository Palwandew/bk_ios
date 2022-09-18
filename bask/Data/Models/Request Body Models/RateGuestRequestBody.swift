//
//  RateGuestRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 18/09/2022.
//

import Foundation

// MARK: - RateGuestRequestBody
struct RateGuestRequestBody: Codable {
    let author, ratedObject: String
    let bookingID: Int
    let rateGuestRequestBodyDescription: String
    let rating: [RateGuestRating]

    enum CodingKeys: String, CodingKey {
        case author
        case ratedObject = "rated_object"
        case bookingID = "booking_id"
        case rateGuestRequestBodyDescription = "description"
        case rating
    }
}

// MARK: - RateGuestRating
struct RateGuestRating: Codable {
    let rubricID, star: Int

    enum CodingKeys: String, CodingKey {
        case rubricID = "rubric_id"
        case star
    }
}
