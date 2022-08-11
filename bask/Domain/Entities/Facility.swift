//
//  Facility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/08/2022.
//

import Foundation

//MARK: - Facility Entity
struct Facility {
    
    //MARK: - Properties
    
    var id: String? = nil 
    var englishName: String = ""
    var arabicName: String = ""
    var length: String = ""
    var width: String = ""
    var livingRooms: [Room] = []
    var kitchen: Int = 0
    var capacity: Int = 8
    var bathrooms: Int = 0
    var showers: Int = 0
    var wifi: Bool = true 
    var parking: Bool = true
    var freeIndoorSwimmingPools: [AmenityFree] = []
    var freeOutdoorSwimmingPools: [AmenityFree] = []
    var outdoorSitting: Bool = false
    var bbq: Bool = false 
    var gym: Bool = false
    var gamesRoom: Bool = false
    var garden: Bool = false
    var playingField: Bool = false
    let nameStatus: Int = 1
    let room_status: Int = 1
    
    
    //MARK: - Name validation
    func validateName() throws  {
        
        if englishName.isEmpty || englishName.count < 3 {
            throw FacilityErrors.invalidEnglishName
        } else if arabicName.isEmpty || arabicName.count < 3 {
            throw FacilityErrors.invalidArabicName
        }
       // return true

    }
    
    //MARK: - Area validation
    func validateArea() throws {
        if length.isEmpty && width.isEmpty {
            throw FacilityErrors.emptyArea
        } else if length.isEmpty || Int(length) ?? 0 <= 0 {
            throw FacilityErrors.invalidLength
        } else if width.isEmpty || Int(width) ?? 0 <= 0 {
            throw FacilityErrors.invalidWidth
        }
    }
    
    
    //MARK: - Living Rooms Validation
    func hasValidLivingRooms() -> Bool {
        if let room = livingRooms.first(where: { $0.length.isEmpty || $0.width.isEmpty}) {
            
            if room.length.isEmpty && room.width.isEmpty {
                room.validLength = false
                room.validWidth = false
                
            } else if room.length.isEmpty {
                room.validLength = false
                
            } else {
                room.validWidth = false
                
            }
            
            return false
        } else {
            _ = livingRooms.map {
                $0.validLength = true
                $0.validWidth = true
            }
            
            return true
        }
    }
    
    
    //MARK: - Step-1 Request body
    func prepareRequestBodyWith(ownerID: String) -> FacilityNameBodyData {
        return FacilityNameBodyData(arabicName: self.arabicName, englishName: self.englishName, ownerID: ownerID)
    }
    
    
    //MARK: - Step-2 Request body
    func prepareRequestBody() -> FacilityAreaBodyData {
        
            
            let data = FacilityAreaBodyData(length: Int(self.length) ?? 0, width: Int(self.width) ?? 0, capacity: self.capacity, noOfShowers: self.showers, noOfBathRooms: self.bathrooms)
            
            return data
     
    }
    
    
    //MARK: - Mutating functions
    mutating func addRoom(){
        let room = Room()
        livingRooms.append(room)
    }
    
    mutating func removeRoom(){
        if !livingRooms.isEmpty {
            livingRooms.removeLast(1)
        }
    }
    
    
    mutating func addIndoorSwimmingPool(){
        let pool = AmenityFree(serviceTypeId: 5)
        freeIndoorSwimmingPools.append(pool)
    }
    
    mutating func removeIndoorSwimmingPool(){
        if !freeIndoorSwimmingPools.isEmpty {
            freeIndoorSwimmingPools.removeLast(1)
        }
    }
    
    mutating func addOutdoorSwimmingPool(){
        let pool = AmenityFree(serviceTypeId: 6)
        freeOutdoorSwimmingPools.append(pool)
    }
    
    mutating func removeOutdoorSwimmingPool(){
        if !freeOutdoorSwimmingPools.isEmpty {
            freeOutdoorSwimmingPools.removeLast(1)
        }
    }
    
    mutating func increaseCounterOf(_ counter: Counter) {
        switch counter {
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
    
    mutating func decreaseCounterOf(_ counter: Counter) {
        switch counter {
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

enum Counter {
    case kitchen
    case capacity
    case bathroom
    case showers
}


enum FacilityErrors: Error {
    case invalidEnglishName
    case invalidArabicName
    case invalidLength
    case invalidWidth
    case emptyArea
    case zero
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


// MARK: - FacilityAreaBodyData
struct FacilityAreaBodyData: Codable {
    let length, width, capacity: Int
    let noOfShowers, noOfBathRooms: Int
    let roomsStatus: Int = 1

    enum CodingKeys: String, CodingKey {
        case length, width, capacity, noOfBathRooms, noOfShowers
        case roomsStatus = "rooms_status"
    }
}
