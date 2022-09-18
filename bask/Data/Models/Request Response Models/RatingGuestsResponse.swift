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
    let unratedGuests: [GuestAndBookingData]
    let ratedGuests: [GuestAndBookingData]

    enum CodingKeys: String, CodingKey {
        case unratedGuests = "unrated_guests"
        case ratedGuests = "rated_guests"
    }
}

// MARK: - UnratedGuestBookingData
struct GuestAndBookingData: Codable {
    let bookingID: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter, checkOutBefore, address: String
    let ratinginfo: [RatingInfo]
    let complain: [Int]?
    let customer: RatingGuest

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
struct RatingGuest: Codable {
    let id, fullName: String
    let photo: String
}



// MARK: - RatedGuest
//struct RatedGuestBookingData: Codable {
//    let bookingID: Int
//    let bookingDates: BookingDates
//    let englishName, checkInAfter, checkOutBefore, address: String
//    let ratinginfo: [Ratinginfo]
//    let complain: [Int]?
//    let customer: RatingGuest
//
//    enum CodingKeys: String, CodingKey {
//        case bookingID = "booking_id"
//        case bookingDates = "booking_dates"
//        case englishName
//        case checkInAfter = "check_in_after"
//        case checkOutBefore = "check_out_before"
//        case address, ratinginfo, complain, customer
//    }
//}

// MARK: - Ratinginfo
struct RatingInfo: Codable {
    let id: Int
    let author, ratedObject: String
    let bookingID: Int
    let ratinginfoDescription: String
    let rating: [RatingStar]

    enum CodingKeys: String, CodingKey {
        case id, author
        case ratedObject = "rated_object"
        case bookingID = "booking_id"
        case ratinginfoDescription = "description"
        case rating
    }
}

// MARK: - RatingStar
struct RatingStar: Codable {
    let star: Int
}
