//
//  Facility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/08/2022.
//

import Foundation


struct Facility {
    var id: String? = nil 
    var englishName: String = ""
    var arabicName: String = ""
    var length: String = ""
    var width: String = ""
    var kitchen: Int
    var capacity: Int
    var bathrooms: Int
    var showers: Int
    var outdoorSitting: Bool = false
    var bbq: Bool = true
    var gym: Bool = false
    var gamesRoom: Bool = false
    var garden: Bool = false
    var playingField: Bool = false
    let nameStatus: Int = 1
    let room_status: Int = 1
    
    func validateName() throws  {
        
        if englishName.isEmpty || englishName.count < 3 {
            throw FacilityErrors.invalidEnglishName
        } else if arabicName.isEmpty || arabicName.count < 3 {
            throw FacilityErrors.invalidArabicName
        }
       // return true

    }
    
    func prepareRequestBodyWith(ownerID: String) -> FacilityNameBodyData {
        return FacilityNameBodyData(arabicName: self.arabicName, englishName: self.englishName, ownerID: ownerID)
    }
    
    mutating func increaseCounterOf(_ amenity: Amenity) {
        switch amenity {
        case .capacity:
            capacity += 1
        case .bathroom:
            bathrooms += 1
        case .showers:
            showers += 1
        case .kitchen:
            kitchen += 1
        }
    }
    
    mutating func decreaseCounterOf(_ amenity: Amenity) {
        switch amenity {
        case .capacity:
            if capacity > 0 {
                capacity -= 1
            }
        case .bathroom:
            if bathrooms > 0 {
                bathrooms -= 1
            }
        case .showers:
            if showers > 0 {
                showers -= 1
            }
        case .kitchen:
            if kitchen > 0 {
                kitchen -= 1
            }
        }
    }
}

enum Amenity {
    case kitchen
    case capacity
    case bathroom
    case showers
}


enum FacilityErrors: Error {
    case invalidEnglishName
    case invalidArabicName
}


// MARK: - FacilityNameData
struct FacilityNameBodyData: Codable {
    let arabicName, englishName, ownerID: String
    let status: String = "unpublished"
    let nameStatus: Int = 1

    enum CodingKeys: String, CodingKey {
        case arabicName, englishName
        case ownerID = "ownerId"
        case status
        case nameStatus = "name_status"
    }
}
