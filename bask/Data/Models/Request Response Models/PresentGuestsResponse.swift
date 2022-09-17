//
//  PresentGuestsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

// MARK: - PresentGuestsResponse
struct PresentGuestsResponse: Codable {
    let data: PresentGuestsData
    let error: Bool
    let message: String
}

// MARK: - PresentGuestsData
struct PresentGuestsData: Codable {
    let presentGuests: [PresentGuest]

    enum CodingKeys: String, CodingKey {
        case presentGuests = "present_guests"
    }
}

// MARK: - PresentGuest
struct PresentGuest: Codable {
    let id: Int
    let bookingDates: BookingDates // BookingDates is defined in BookedFacilitiesResponse 
    let englishName, checkInAfter, checkOutBefore, address: String
    let customer: Customer // Customer is defined in UpcomingGuestsResponse

    enum CodingKeys: String, CodingKey {
        case id
        case bookingDates = "booking_dates"
        case englishName
        case checkInAfter = "check_in_after"
        case checkOutBefore = "check_out_before"
        case address, customer
    }
}

