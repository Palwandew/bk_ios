//
//  UpcomingGuestsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

// MARK: - UpcomingGuestsResponse
struct UpcomingGuestsResponse: Codable {
    let data: UpcomingGuestsDataClass
    let error: Bool
    let message: String
}

// MARK: - UpcomingGuests
struct UpcomingGuestsDataClass: Codable {
    let upcomingGuests: [UpcomingGuest]

    enum CodingKeys: String, CodingKey {
        case upcomingGuests = "upcoming_guests"
    }
}

// MARK: - UpcomingGuest
struct UpcomingGuest: Codable {
    let id: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter, checkOutBefore, address: String
    let customer: Customer

    enum CodingKeys: String, CodingKey {
        case id
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case checkOutBefore = "check_out_before"
        case address, customer
    }
}

// MARK: - BookingDates
struct BookingDatess: Codable {
    let startDate, endDate: String

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

// MARK: - Customer
struct Customer: Codable {
    let fullName: String
    let photo: String
}
