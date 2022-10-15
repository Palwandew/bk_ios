//
//  UpdateCalendarDayRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/10/2022.
//


import Foundation

// MARK: - UpdatedCalendarDay
struct UpdatedCalendarDay: Encodable {
    let facilityID, date, status: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facilityId"
        case date, status
    }
}

typealias GetFacilityCalendarDays = [UpdatedCalendarDay]
