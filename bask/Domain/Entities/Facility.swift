//
//  Facility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/08/2022.
//

import Foundation


struct Facility {
    var length: String = ""
    var width: String = ""
    var kitchen: Int
    var capacity: Int
    var bathrooms: Int
    var showers: Int
    let room_status: Int = 1
    
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
    
//    private func checkAmenityCount(_ amenity: Int) -> Bool {
//        if amenity >= 0 {
//
//            return
//        }
//    }
}

enum Amenity {
    case kitchen
    case capacity
    case bathroom
    case showers
}
