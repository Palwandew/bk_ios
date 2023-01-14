//
//  OwnerPastBookingsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/10/2022.
//

import Foundation

// MARK: - OwnerPastBookingsResponse
struct OwnerPastBookingsResponse: Codable {
    let data: OwnerPastBookingsData
    let error: Bool
    let message: String
}

// MARK: - OwnerPastBookingsData
struct OwnerPastBookingsData: Codable {
    let pastBookings: [PastBookingOld]

    enum CodingKeys: String, CodingKey {
        case pastBookings = "past_bookings"
    }
}

// MARK: - PastBooking
struct PastBookingOld: Codable {
    let id, price: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter: String
    let bookingstatus: PastBookingStatus//
    let facility: PastBookingFacility

    enum CodingKeys: String, CodingKey {
        case id, price
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case bookingstatus, facility
    }
}

struct PastBookingStatus: Codable {
    let statusName: String
}

// MARK: - PastBookingFacility
struct PastBookingFacility: Codable {
    let id: String
    let images: [FacilityImage]
}

