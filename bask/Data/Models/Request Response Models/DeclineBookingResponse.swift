//
//  DeclineBookingResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/10/2022.
//

import Foundation

// MARK: - DeclineBookingResponse
struct DeclineBookingResponse: Codable {
    let data: DeclineBookingResponseData
    let error: Bool
    let message: String
}

// MARK: - DeclineBookingResponseData
struct DeclineBookingResponseData: Codable {
    let booking: DeclinedBooking
}

// MARK: - DeclinedBooking
struct DeclinedBooking: Codable {
    let statusID, id, price: Int
    let customerID, facilityID: String
    let bookingDates: BookingDates
    let nightsBooked: Int
    let tranRef, checkInDate, checkOutDate: JSONNull?
    let bookingstatus: DeclinedBookingStatus

    enum CodingKeys: String, CodingKey {
        case statusID = "status_id"
        case id, price
        case customerID = "customer_id"
        case facilityID = "facility_id"
        case bookingDates = "booking_dates"
        case nightsBooked = "nights_booked"
        case tranRef = "tran_ref"
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case bookingstatus
    }
}



// MARK: - DeclinedBookingStatus
struct DeclinedBookingStatus: Codable {
    let id: Int
    let statusName: String
}
