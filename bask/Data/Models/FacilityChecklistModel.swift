//
//  FacilityChecklistModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/08/2022.
//

import Foundation


// MARK: - FacilityChecklistModel
struct FacilityChecklistModel: Codable {
    let data: FacilityChecklistModelData
    let error: Bool
    let message: String
    
    
    func dotCheclistEntity() -> Checklist{
        return Checklist(data.facility.nameStatus, data.facility.roomsStatus, data.facility.amenityFreeStatus, data.facility.amenityExtraStatus, data.facility.rulesStatus, data.facility.photoStatus, data.facility.locationStatus, data.facility.checkInOutStatus, data.facility.priceStatus, data.facility.descriptionStatus)
    }
}

// MARK: - FacilityChecklistModelData
struct FacilityChecklistModelData: Codable {
    let facility: FacilityChecklist
}

// MARK: - FacilityChecklist
struct FacilityChecklist: Codable {
    let nameStatus, roomsStatus, amenityFreeStatus, amenityExtraStatus: Int
    let rulesStatus, photoStatus, locationStatus, checkInOutStatus: Int
    let priceStatus, descriptionStatus: Int

    enum CodingKeys: String, CodingKey {
        case nameStatus = "name_status"
        case roomsStatus = "rooms_status"
        case amenityFreeStatus = "amenity_free_status"
        case amenityExtraStatus = "amenity_extra_status"
        case rulesStatus = "rules_status"
        case photoStatus = "photo_status"
        case locationStatus = "location_status"
        case checkInOutStatus = "check_in_out_status"
        case priceStatus = "price_status"
        case descriptionStatus = "description_status"
    }
}
