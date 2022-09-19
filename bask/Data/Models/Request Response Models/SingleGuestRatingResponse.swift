//
//  SingleGuestRatingResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 19/09/2022.
//

import Foundation

// MARK: - SingleGuestRatingResponse
struct SingleGuestRatingResponse: Codable {
    let data: SingleGuestRatingResponseData
    let error: Bool
    let message: String
}

// MARK: - SingleGuestRatingResponseData
struct SingleGuestRatingResponseData: Codable {
    let ratings: [RatingData]
}

// MARK: - RatingData
struct RatingData: Codable {
    let ratingDescription: String
    let rating: [RatingRubric]
    let booking: RatingBooking
    let facility: [String]? // This shall be empty, since we're getting the guest rating data.
    let guest: Customer

    enum CodingKeys: String, CodingKey {
        case ratingDescription = "description"
        case rating, booking, facility, guest
    }
}

// MARK: - RatingBooking
struct RatingBooking: Codable {
    let bookingDates: BookingDates

    enum CodingKeys: String, CodingKey {
        case bookingDates = "booking_dates"
    }
}


// MARK: - RatingRubric
struct RatingRubric: Codable {
    let star, id, rubricID: Int

    enum CodingKeys: String, CodingKey {
        case star, id
        case rubricID = "rubric_id"
    }
    
    func dotQuestionEntity() -> Question {
        return Question(rubricId: rubricID, stars: star, idFromDB: id)
    }
}
