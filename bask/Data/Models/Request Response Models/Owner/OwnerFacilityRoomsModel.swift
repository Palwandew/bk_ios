// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:


import Foundation

// MARK: - OwnerFacilityRoomsModel
struct OwnerFacilityRoomsModel: Codable {
    let data: OwnerFacilityRoomsData
    let error: Bool
    let message: String
}

// MARK: - OwnerFacilityRoomsData
struct OwnerFacilityRoomsData: Codable {
    let facilityservices: [Facilityservice]
    let otherData: RoomsCount
    let page, pageCount: Int
}

// MARK: - Facilityservice
struct Facilityservice: Codable {
    let id: Int
    let facilityID: String
    let serviceTypeID, price, length, width: Int
    let facilityserviceDescription: String?
    let isFree: Bool
    let priceUnit: String?
    let facilityservicetype: Facilityservicetype

    enum CodingKeys: String, CodingKey {
        case id
        case facilityID = "facilityId"
        case serviceTypeID = "serviceTypeId"
        case price, length, width
        case facilityserviceDescription = "description"
        case isFree, priceUnit, facilityservicetype
    }
}

// MARK: - Facilityservicetype
struct Facilityservicetype: Codable {
    let id: Int
    let serviceName: String
}

// MARK: - OtherData
struct RoomsCount: Codable {
    let length, width, capacity, noOfBathRooms: Int
    let noOfShowers: Int
}
