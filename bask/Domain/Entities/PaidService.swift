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
    var indoorPools: Int = 0
    var outdoorPools: Int = 0
    var outdoorSitting: Bool = false
    var bbq: Bool = false
    var gym: Bool = false
    var gamesRoom: Bool = false
    var garden: Bool = false
    var playingField: Bool = false
    
    
    //MARK: - Wifi price validation
    
    func validateWifiPrice() -> Bool {
        if wifi {
            if wifiPrice.price.isEmpty {
                wifiPrice.validPrice = false
                
            } else {
                wifiPrice.validPrice = true 
            }
            
            return wifiPrice.validPrice
        } else {
            return true
        }
    }
    
    
    //MARK: - Parking price validation
    
    func validateParkingPrice() -> Bool {
        if parking {
            if parkingPrice.price.isEmpty {
                parkingPrice.validPrice = false
            } else {
                parkingPrice.validPrice = true
            }
            return parkingPrice.validPrice
        } else {
            return true
        }
    }
    
    
    //MARK: - Validate swimming pools
    
    func hasValidPools(_ type: SwimmingPool) -> Bool {
        
        switch type {
        case .indoor:
            return isInvalidPool(in: indoorSwimmingPools)
        case .outdoor:
            return isInvalidPool(in: outdoorSwimmingPools)
        }
        
    }
    
    private func isInvalidPool(in list: [AmenityPaid]) -> Bool {
        if let pool = list.first(where: { $0.length.isEmpty || $0.width.isEmpty || $0.price.isEmpty}) {
            
            if pool.price.isEmpty {
                pool.validPrice = false
            }
            
            if pool.length.isEmpty {
                pool.validLength = false
            }
            
            if pool.width.isEmpty {
                pool.validWidth = false
            }
            
            return false
        } else {
            _ = list.map {
                $0.validPrice = true
                $0.validLength = true
                $0.validWidth = true
            }
            
            return true
        }
    }
    
    //MARK: - Mutating functions
    
    mutating func addPool(_ type: SwimmingPool){
        switch type {
        case .indoor:
            let indoorPool = AmenityPaid(serviceTypeId: 5)
            indoorSwimmingPools.append(indoorPool)
            indoorPools += 1
        case .outdoor:
            let outdoorPool = AmenityPaid(serviceTypeId: 6)
            outdoorSwimmingPools.append(outdoorPool)
            outdoorPools += 1
        }

    }
    
    mutating func removePool(_ type: SwimmingPool){
        
        switch type {
        case .indoor:
            if !indoorSwimmingPools.isEmpty {
                indoorSwimmingPools.removeLast(1)
                indoorPools -= 1
            }
        case .outdoor:
            if !outdoorSwimmingPools.isEmpty {
                outdoorSwimmingPools.removeLast(1)
                outdoorPools -= 1
            }
        }
    }
}

enum SwimmingPool{
    case indoor
    case outdoor
}
