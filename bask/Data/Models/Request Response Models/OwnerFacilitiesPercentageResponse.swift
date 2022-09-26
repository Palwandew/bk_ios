//
//  OwnerFacilitiesPercentageResponse.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

// MARK: - OwnerFacilitiesPercentageResponse
struct OwnerFacilitiesPercentageResponse: Codable {
    let data: OwnerFacilitiesPercentageData
    let error: Bool
    let message: String
    
    func facilityPercentages() -> [FacilityPercentage] {
        return data.results.map{$0.dotFacilityPercentageEntity()}
    }
    
}

// MARK: - OwnerFacilitiesPercentageData
struct OwnerFacilitiesPercentageData: Codable {
    let results: [FacilityPercentageModel]
    let total, page, pageCount: Int
}

// MARK: - Result
struct FacilityPercentageModel: Codable {
    let resultDescription: String?
    let feePercentage: Int?
    let images: [FacilityImage]

    enum CodingKeys: String, CodingKey {
        case resultDescription = "description"
        case feePercentage, images
    }
    
    func dotFacilityPercentageEntity() -> FacilityPercentage {
        
        let name = resultDescription ?? ""
        let percentage = feePercentage ?? 0
        let photo = images.first?.photo ?? ""
        
        return FacilityPercentage(name: name, percentage: percentage, photoURL: photo)
    }
}
