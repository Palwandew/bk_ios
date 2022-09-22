//
//  NewOfferRequestBody.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 22/09/2022.
//

import Foundation

// MARK: - NewOfferRequestBody
struct NewOfferRequestBody: Codable {
    let facilityID: String
    let discount: Int
    let discountType, startDate, endDate: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case discount
        case discountType = "discount_type"
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    static func fromEntity(_ entity: Offer) -> NewOfferRequestBody? {
        let facilityID = entity.facilityID
        let discount = Int(entity.discount)
        guard let discountInt = discount else {
            return nil
        }
        let discountType = entity.type
        
        guard let startDate = entity.startDate, let endDate = entity.endDate else {
            return nil
        }
        
        let startDateString = DateFormatter.full.string(from: startDate)
        let endDateString = DateFormatter.full.string(from: endDate)
        
        return NewOfferRequestBody(
            facilityID: facilityID,
            discount: discountInt,
            discountType: discountType,
            startDate: startDateString,
            endDate: endDateString)
        
        
    }
}
