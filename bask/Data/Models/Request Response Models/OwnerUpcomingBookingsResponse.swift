//
//  OwnerUpcomingBookingsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import Foundation

// MARK: - OwnerUpcomingBookingResponse
struct OwnerUpcomingBookingResponse: Codable {
    let data: OwnerUpcomingBookingsData
    let error: Bool
    let message: String
}

// MARK: - OwnerUpcomingBookingsData
struct OwnerUpcomingBookingsData: Codable {
    let upcomingBookings: [UpcomingBooking]

    enum CodingKeys: String, CodingKey {
        case upcomingBookings = "upcoming_bookings"
    }
}

// MARK: - UpcomingBooking
struct UpcomingBooking: Codable {
    let id, price: Int
    let bookingDates: BookingDates
    let englishName, checkInAfter: String
    let remainingTime: RemainingTime
    let facility: UpcomingBookingFacility
    let bookingstatus: UpcomingBookingstatus

    enum CodingKeys: String, CodingKey {
        case id, price
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case remainingTime = "remaining_time"
        case facility, bookingstatus
    }
}


//// MARK: - BookingDates
//struct BookingDates: Codable {
//    let startDate, endDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case startDate = "start_date"
//        case endDate = "end_date"
//    }
//}

// MARK: - UpcomingBookingstatus
struct UpcomingBookingstatus: Codable {
    let statusName: String
}

// MARK: - Facility
struct UpcomingBookingFacility: Codable {
    let id: String
    let images: [FacilityImage]
}
//
//// MARK: - Image
//struct Image: Codable {
//    let photo: String
//}

// MARK: - RemainingTime
struct RemainingTime: Codable {
    let days, hours, minutes: Int
}
