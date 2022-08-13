//
//  PaidService.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/08/2022.
//

import Foundation

class PaidService {
    
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
    
    
    //MARK: - Mutating functions
//    mutating func addAmenity(){
//        let room = Room()
//        livingRooms.append(room)
//    }
    
//    mutating func removeAmenity(){
//        if !livingRooms.isEmpty {
//            livingRooms.removeLast(1)
//        }
//    }
    
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
}
