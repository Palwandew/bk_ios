//
//  PaidService.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/08/2022.
//

import Foundation

struct PaidService {
    
    //MARK: - Properties
    var wifi: Bool = false 
    var wifiPrice: AmenityPaid = AmenityPaid(serviceTypeId: 3)
    var parking: Bool = false
    var parkingPrice: AmenityPaid = AmenityPaid(serviceTypeId: 4)
    var indoorSwimmingPools: [AmenityPaid] = []
    var outdoorSwimmingPools: [AmenityPaid] = []
    var outdoorSitting: Bool = false
    var bbq: Bool = false
    var gym: Bool = false
    var gamesRoom: Bool = false
    var garden: Bool = false
    var playingField: Bool = false
    
    
    func validateWifiPrice() {
        if wifi {
            if wifiPrice.price.isEmpty {
                wifiPrice.validPrice = false
            } else {
                wifiPrice.validPrice = true 
            }
        }
    }
    
    func validateParkingPrice() {
        if parking {
            if parkingPrice.price.isEmpty {
                parkingPrice.validPrice = false
            } else {
                parkingPrice.validPrice = true
            }
        }
    }
    
    //MARK: - Mutating functions
    mutating func addPool(_ type: SwimmingPool){
        switch type {
        case .indoor:
            let indoorPool = AmenityPaid(serviceTypeId: 5)
            indoorSwimmingPools.append(indoorPool)
        case .outdoor:
            let outdoorPool = AmenityPaid(serviceTypeId: 5)
            outdoorSwimmingPools.append(outdoorPool)
        }

    }
    
    mutating func removePool(_ type: SwimmingPool){
        
        switch type {
        case .indoor:
            if !indoorSwimmingPools.isEmpty {
                indoorSwimmingPools.removeLast(1)
            }
        case .outdoor:
            if !outdoorSwimmingPools.isEmpty {
                outdoorSwimmingPools.removeLast(1)
            }
        }
    }
}

enum SwimmingPool{
    case indoor
    case outdoor
}
