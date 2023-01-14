//
//  OwnerPresentBookingsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/10/2022.
//

import Foundation

// MARK: - OwnerPresentBookingsResponse
struct OwnerPresentBookingsResponse: Codable {
    let data: OwnerPresentBookingsData
    let error: Bool
    let message: String
}

// MARK: - OwnerPresentBookingsData
struct OwnerPresentBookingsData: Codable {
    let presentBookings: [PresentBookingOld]

    enum CodingKeys: String, CodingKey {
        case presentBookings = "present_bookings"
    }
}

// MARK: - PresentBooking
struct PresentBookingOld: Codable {
    let id, price: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter: String
    let remainingTime: PresentBookingRemainingTime
    let facility: PresentBookingFacility

    enum CodingKeys: String, CodingKey {
        case id, price
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case remainingTime = "remaining_time"
        case facility
    }
}



// MARK: - PresentBookingRemainingTime
struct PresentBookingRemainingTime: Codable {
    let hours, minutes: Int
}

// MARK: - PresentBookingFacility
struct PresentBookingFacility: Codable {
    let id: String
    let images: [FacilityImage]
}



