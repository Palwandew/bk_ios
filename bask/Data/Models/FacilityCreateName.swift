//
//  FacilityCreateName.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/08/2022.
//

import Foundation

// MARK: - FacilityCreateName
struct FacilityCreateName: Codable {
    let data: FacilityNameData
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct FacilityNameData: Codable {
    let facility: FacilityCreated
}

// MARK: - Facility
struct FacilityCreated: Codable {
    let arabicName, englishName, ownerID, status: String
    let nameStatus: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case arabicName, englishName
        case ownerID = "ownerId"
        case status
        case nameStatus = "name_status"
        case id
    }
}
