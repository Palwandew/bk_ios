//
//  OwnerUpcomingBookingsResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/09/2022.
//

import Foundation

protocol BookingItem {
    var id: String { get }
    var facilityImage: String? { get }
    var facilityName: String { get }
    var price: Double { get }
    var checkInDate: Date { get }
    var checkOutDate: Date { get }
}

// MARK: - UpcomingBooking
struct UpcomingBooking: Codable, BookingItem {
    let id: String
    let facilityImage: String?
    let facilityName: String
    let price: Double
    let checkInDate: Date
    let checkOutDate: Date
}

typealias UpcomingBookings = [UpcomingBooking]

//MARK: - PresentBooking
struct PresentBooking: Codable, BookingItem {
    let id: String
    let facilityImage: String?
    let facilityName: String
    let price: Double
    let checkInDate: Date
    let checkOutDate: Date
}

typealias PresentBookings = [PresentBooking]

//MARK: - PastBooking
struct PastBooking: Codable, BookingItem {
    let id: String
    let facilityImage: String?
    let facilityName: String
    let price: Double
    let checkInDate: Date
    let checkOutDate: Date
}

typealias PastBookings = [PastBooking]
