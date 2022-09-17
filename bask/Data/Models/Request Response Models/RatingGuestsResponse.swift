//
//  RatingGuestsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

// MARK: - RatingGuestsResponse
struct RatingGuestsResponse: Codable {
    let data: RatingGuestsData
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct RatingGuestsData: Codable {
    let unratedGuests: [UnratedGuestBookingData]
    let ratedGuests: [String]?

    enum CodingKeys: String, CodingKey {
        case unratedGuests = "unrated_guests"
        case ratedGuests = "rated_guests"
    }
}

// MARK: - UnratedGuestBookingData
struct UnratedGuestBookingData: Codable {
    let bookingID: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter, checkOutBefore, address: String
    let ratinginfo: [Int]?
    let complain: [Int]?
    let customer: UnratedGuest

    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case checkOutBefore = "check_out_before"
        case address, ratinginfo, complain, customer
    }
}

// MARK: - Customer
struct UnratedGuest: Codable {
    let id, fullName: String
    let photo: String
}
