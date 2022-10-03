//
//  GetFacilityCalendarDaysResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/10/2022.
//

import Foundation


// MARK: - GetFacilityCalendarDays
struct GetFacilityCalendarDays: Codable {
    let data: FacilityCalendarDaysData
    let error: Bool
    let message: String
}

// MARK: - FacilityCalendarDaysData
struct FacilityCalendarDaysData: Codable {
    let calendar: [CalendarDay]
}

// MARK: - CalendarDay
struct CalendarDay: Codable {
    let id: Int?
    let facilityID, date: String
    let price: Int?
    let status: Status

    enum CodingKeys: String, CodingKey {
        case id
        case facilityID = "facilityId"
        case date, price, status
    }
}

enum Status: String, Codable {
    case available = "available"
    case booked = "booked"
    case unavailable = "unavailable"
}
