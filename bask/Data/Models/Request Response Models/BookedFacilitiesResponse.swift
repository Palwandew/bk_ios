//
//  BookedFacilitiesResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//


import Foundation

// MARK: - BookedFacilitiesResponse
struct BookedFacilitiesResponse: Codable {
    let data: BookedFacilitiesResponseData
    let error: Bool
    let message: String
}

// MARK: - BookedFacilitiesResponseData
struct BookedFacilitiesResponseData: Codable {
    let startDate, endDate: String
    let bookings: [Booking]
    let total, page, pageCount: Int
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case bookings, total, page, pageCount
    }
}

// MARK: - Booking
struct Booking: Codable {
    let bookingID: Int
    let bookingDates: BookingDates
    let facility: BookedFacility
    
    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case bookingDates = "booking_dates"
        case facility
    }
}

// MARK: - BookingDates
struct BookingDates: Codable {
    let startDate, endDate: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
    }
}

// MARK: - Facility
struct BookedFacility: Codable {
    let id, facilityDescription, address: String
    let images: [FacilityImage]
    
    enum CodingKeys: String, CodingKey {
        case id
        case facilityDescription = "description"
        case address, images
    }
}

// MARK: - Image
struct FacilityImage: Codable {
    let photo: String
}
