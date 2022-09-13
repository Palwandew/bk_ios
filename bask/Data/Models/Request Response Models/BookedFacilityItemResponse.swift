//
//  BookedFacilityItemResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import Foundation

// MARK: - BookedFacilityItemResponse
struct BookedFacilityItemResponse: Codable {
    let data: BookedFacilityDataClass
    let error: Bool
    let message: String
}

// MARK: - BookedFacilityDataClass
struct BookedFacilityDataClass: Codable {
    let bookedItem: BookedItem

    enum CodingKeys: String, CodingKey {
        case bookedItem = "booked_item"
    }
}

// MARK: - BookedItem
struct BookedItem: Codable {
    let price: Int
    let bookedItemDescription, englishName, checkInAfter, address: String
    let capacity, length, width: Int
    let latitude, longitude: Double
    let cancellationpolicy: Int?
    let booking: [BookedItemBooking]
    let facilityservices: [JSONAny]
    let images: [FacilityImage]
    let noOfLivingrooms: String
    let reviews: Reviews

    enum CodingKeys: String, CodingKey {
        case price
        case bookedItemDescription = "description"
        case englishName
        case checkInAfter = "check_in_after"
        case address, capacity, length, width, latitude, longitude, cancellationpolicy, booking, facilityservices, images
        case noOfLivingrooms = "no_of_livingrooms"
        case reviews
    }
}

// MARK: - BookedItemBooking
struct BookedItemBooking: Codable {
    let bookingDates: BookingDates
    let price: Int
    let customer: BookedItemCustomer
    let bookingstatus: Bookingstatus

    enum CodingKeys: String, CodingKey {
        case bookingDates = "booking_dates"
        case price, customer, bookingstatus
    }
}


// MARK: - Bookingstatus
struct Bookingstatus: Codable {
    let id: Int
    let statusName: String
}

// MARK: - Customer
struct BookedItemCustomer: Codable {
    let id, fullName: String
    let rating: Double
}

// MARK: - Image
//struct Image: Codable {
//    let photo: String
//}

// MARK: - Reviews
struct Reviews: Codable {
    let reviews: [JSONAny]
    let facilityAvgRating: JSONNull?
    let totalReviews: Int

    enum CodingKeys: String, CodingKey {
        case reviews
        case facilityAvgRating = "facility_avg_rating"
        case totalReviews = "total_reviews"
    }
}
