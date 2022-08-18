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
    
    var id: String? = "879605bb-766e-43bf-9e08-04900a7734eb" // Need to replace it with the actual facility id
    var englishName: String = ""
    var arabicName: String = ""
    var length: String = ""
    var width: String = ""
    var livingRooms: [Room] = []
    var kitchen: Int = 0
    var capacity: Int = 8
    var bathrooms: Int = 0
    var showers: Int = 0
    // Free Amenities
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
    // Paid Amenities
    var paidAmenities: PaidService = PaidService()
    let nameStatus: Int = 1
    let room_status: Int = 1
    // Rules
    var rules: Rules = Rules()
    // Location
    var location: Location = Location()
    // CheckIn
    var checkInAfter: String = ""
    var checkOutBefore: String = ""
    var checkInBefore: String = ""
    let checkInOutStatus: Int = 1
    // Price
    var pricePerNight: String = ""
    var deposit: String = ""
    var validPrice: Bool = true
    var validDeposit: Bool = true
    
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
    
    
    //MARK: - Free Amenities Validation
    func hasValidFreeAmenities() -> Bool {
        if let indoorPool = freeIndoorSwimmingPools.first(where: { $0.length.isEmpty || $0.width.isEmpty}) {
            
            if indoorPool.length.isEmpty && indoorPool.width.isEmpty {
                indoorPool.validLength = false
                indoorPool.validWidth = false
                
            } else if indoorPool.length.isEmpty {
                indoorPool.validLength = false
                
            } else {
                indoorPool.validWidth = false
                
            }
            
            return false
        } else {
            _ = freeIndoorSwimmingPools.map {
                $0.validLength = true
                $0.validWidth = true
            }
            
            return true
        }
    }
    
    
    //MARK: - Paid Amenities Validation
    func hasValidPaidAmenities() -> Bool {
        return paidAmenities.valid()
        
    }
    
    
    //MARK: - Address Validation
    mutating func hasValidAddress() -> Bool {
        return location.validAddress()
    }
    
    
    //MARK: - Timing Validation
    /// Checks if the facility check-in, check-out timings have been added.
    /// - Returns: True if the user has added check-in and check-out timings. False otherwise, if either of
    /// timings is missing.
    func hasValidCheckInTime() -> Bool {
        return !checkInAfter.isEmpty && !checkInBefore.isEmpty && !checkOutBefore.isEmpty
    }
    
    
    //MARK: - Price Validation
    mutating func hasValidPrice() -> Bool {
        
        if pricePerNight.isEmpty {
            validPrice = false
        }
        else if deposit.isEmpty {
            validDeposit = false
        } else {
            validPrice = true
            validDeposit = true 
        }
        return !pricePerNight.isEmpty && !deposit.isEmpty
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
    
    
    //MARK: - Step-3 Request body
    func prepareFreeServicesRequestBody() -> FacilityFreeAmenitiesRequestBody {
        
        var services: [FacilityFreeService] = []
        
        if !freeIndoorSwimmingPools.isEmpty {
            for indoorPool in freeIndoorSwimmingPools {
                let freeIndoorPool = FacilityFreeService(facilityID: id!, serviceTypeID: indoorPool.serviceTypeId, facilityServiceDescription: nil, length: Int(indoorPool.length), width: Int(indoorPool.width))
                services.append(freeIndoorPool)
            }
            
        }
        
        if !freeOutdoorSwimmingPools.isEmpty {
            for outdoorPool in freeIndoorSwimmingPools {
                let freeOutdoorPool = FacilityFreeService(facilityID: id!, serviceTypeID: outdoorPool.serviceTypeId, facilityServiceDescription: nil, length: Int(outdoorPool.length), width: Int(outdoorPool.width))
                services.append(freeOutdoorPool)
            }
        }
        
        if wifi {
            let wifiService = FacilityFreeService(facilityID: id!, serviceTypeID: 3, facilityServiceDescription: nil, length: nil, width: nil)
            services.append(wifiService)
        }
        
        if parking {
            let parkingService = FacilityFreeService(facilityID: id!, serviceTypeID: 4, facilityServiceDescription: nil, length: nil, width: nil)
            services.append(parkingService)
        }
        
        return FacilityFreeAmenitiesRequestBody(facilityservices: services, facilityID: id ?? "")
    }
    
    
    //MARK: - Step-4 Request body
    
    func preparePaidServicesRequestBody() -> FacilityPaidAmenitiesRequestBody{
        
        let services = paidAmenities.preparePaidServices(for: id ?? "")
        
        return FacilityPaidAmenitiesRequestBody(facilityservices: services, facilityID: id ?? "")
        
    }
    
    
    //MARK: - Step-5 Request body
    
    func prepareRulesRequestBody() -> FacilityRulesRequestBody {
        return rules.toRequestBodyModel()
    }
    
    
    //MARK: - Step-6 Request body
    
    func prepareLocationRequestBody() -> FacilityLocationRequestBody {
        return location.toRequestBodyModel()
    }
    
    
    //MARK: - Step-7 Request body
    
    func prepareCheckInTimeRequestBody() -> FacilityCheckInTimeRequestBody {
        return FacilityCheckInTimeRequestBody(checkInAfter: self.checkInAfter, checkInBefore: self.checkInBefore, checkOutBefore: self.checkOutBefore, checkInOutStatus: self.checkInOutStatus)
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


// MARK: - FacilityFreeAmenities
struct FacilityFreeAmenitiesRequestBody: Codable {
    let facilityservices: [FacilityFreeService]
    let facilityID: String
    
    enum CodingKeys: String, CodingKey {
        case facilityservices
        case facilityID = "facilityId"
    }
}

// MARK: - Facilityservice
struct FacilityFreeService: Codable {
    let facilityID: String
    let serviceTypeID: Int
    let facilityServiceDescription: String?
    let length, width: Int?
    
    enum CodingKeys: String, CodingKey {
        case facilityID = "facilityId"
        case serviceTypeID = "serviceTypeId"
        case facilityServiceDescription = "description"
        case length, width
    }
}

// MARK: - FacilityRulesRequestBody
struct FacilityRulesRequestBody: Codable {
    let petsAllowed, petsAllAllowed, petsCatsAllowed, petsDogsAllowed: Bool
    let petsRodentsAllowed, petsReptileAllowed, petsBigAnimalAllowed, smokingAllowed: Bool
    let additionalRules: Bool
    let additionalRulesDescription: String
    let rulesStatus: Int

    enum CodingKeys: String, CodingKey {
        case petsAllowed, petsAllAllowed, petsCatsAllowed, petsDogsAllowed, petsRodentsAllowed, petsReptileAllowed, petsBigAnimalAllowed, smokingAllowed, additionalRules, additionalRulesDescription
        case rulesStatus = "rules_status"
    }
}

// MARK: - FacilityCheckInTimeRequestBody
struct FacilityCheckInTimeRequestBody: Codable {
    let checkInAfter, checkInBefore, checkOutBefore: String
    let checkInOutStatus: Int

    enum CodingKeys: String, CodingKey {
        case checkInAfter = "check_in_after"
        case checkInBefore = "check_in_before"
        case checkOutBefore = "check_out_before"
        case checkInOutStatus = "check_in_out_status"
    }
}

