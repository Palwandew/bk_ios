//
//  ComplainRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 19/09/2022.
//

import Foundation

// MARK: - ComplainRequestBody
struct ComplainRequestBody: Codable {
    let requestBy, defandant, type: String
    let bookingID: Int
    let dueDate, body: String

    enum CodingKeys: String, CodingKey {
        case requestBy = "request_by"
        case defandant, type
        case bookingID = "booking_id"
        case dueDate = "due_date"
        case body
    }
}
