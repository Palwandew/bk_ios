//
//  Facility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/08/2022.
//

import Foundation

//MARK: - Facility Entity
struct Facility: Codable {
    
    //MARK: - Properties
    let id: String?
    let arabicName, englishName, facilityDescription, facilityType: String
    let ownerID: String
    let price: Int
    let country, address, city: String
    let latitude: Double
    let cancellationPolicyID, length, width, capacity: Int
    let noOfBathRooms, noOfShowers, feePercentage: Int
    let status: String
    let garden, playingField, gym, outdoorSitting: Bool
    let bbqArea, petsAllowed, petsAllAllowed, petsCatsAllowed: Bool
    let petsDogsAllowed, petsRodentsAllowed, petsReptileAllowed, petsBigAnimalAllowed: Bool
    let smokingAllowed, additionalRules: Bool
    let additionalRulesDescription: String
    let longitude: Double
    let checkInAfter, checkInBefore, checkOutBefore: String
    let deposit, nameStatus, roomsStatus, amenityFreeStatus: Int
    let amenityExtraStatus, rulesStatus, photoStatus, locationStatus: Int
    let checkInOutStatus, priceStatus, descriptionStatus: Int
    
    enum CodingKeys: String, CodingKey {
            case id
            case arabicName, englishName
            case facilityDescription = "description"
            case facilityType
            case ownerID = "ownerId"
            case price, country, address, city, latitude
            case cancellationPolicyID = "cancellationPolicyId"
            case length, width, capacity, noOfBathRooms, noOfShowers, feePercentage, status, garden
            case playingField = "playing_field"
            case gym
            case outdoorSitting = "outdoor_sitting"
            case bbqArea = "bbq_area"
            case petsAllowed, petsAllAllowed, petsCatsAllowed, petsDogsAllowed, petsRodentsAllowed, petsReptileAllowed, petsBigAnimalAllowed, smokingAllowed, additionalRules, additionalRulesDescription, longitude
            case checkInAfter = "check_in_after"
            case checkInBefore = "check_in_before"
            case checkOutBefore = "check_out_before"
            case deposit
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

//MARK: - Facility Creation Respo
// MARK: - Facility
struct FacilityCreationResponse: Codable {
    let data: FacilityCreationResponseData
    let error: Bool
    let message: String
}

// MARK: - DataClass
struct FacilityCreationResponseData: Codable {
    let facility: Facility
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

// MARK: - FacilityPriceRequestBody
struct FacilityPriceRequestBody: Codable {
    let price, deposit, priceStatus: Int
    
    enum CodingKeys: String, CodingKey {
        case price, deposit
        case priceStatus = "price_status"
    }
}


// MARK: - FacilityDescriptionRequestBody
struct FacilityDescriptionRequestBody: Codable {
    let facilityDescriptionRequestBodyDescription: String
    let descriptionStatus: Int
    
    enum CodingKeys: String, CodingKey {
        case facilityDescriptionRequestBodyDescription = "description"
        case descriptionStatus = "description_status"
    }
}


enum FacilityCreationStep {
    
    case stepTwo
    case stepThree
    case stepFour
    case stepFive
    case stepSix
    case stepSeven
    case stepEight
    case stepNine
    case stepTen
}

//MARK: - FacilityPublishRequestBody
struct FacilityPublishRequestBody: Codable {
    let status: String
}



/// Builder class to create Facility object using builder pattfrom
class FacilityBuilder {
    private var arabicName, englishName, facilityDescription, facilityType: String
    private var ownerID: String
    private var price, deposit: Int
    private var country, address, city: String
    private var latitude, longitude: Double
    private var cancellationPolicyID, length, width, capacity: Int
    private var noOfBathRooms, noOfShowers, feePercentage: Int
    private var status: String
    private var garden, playingField, gym, outdoorSitting: Bool
    private var bbqArea, petsAllowed, petsAllAllowed, petsCatsAllowed: Bool
    private var petsDogsAllowed, petsRodentsAllowed, petsReptileAllowed, petsBigAnimalAllowed: Bool
    private var smokingAllowed, additionalRules: Bool
    private var additionalRulesDescription: String
    private var checkInAfter, checkOutBefore: String
    
    init(){
        ownerID = ""
        status = ""
        arabicName = ""
        englishName = ""
        facilityDescription = ""
        facilityType = "Farm house"
        price = 0
        deposit = 0
        country = "Saudi Arabia"
        address = ""
        city = ""
        latitude = 0.0
        longitude = 0.0
        cancellationPolicyID = 1
        length = 0
        width = 0
        capacity = 0
        noOfBathRooms = 0
        noOfShowers = 0
        feePercentage = 0
        garden = false
        playingField = false
        gym = false
        outdoorSitting = false
        bbqArea = false
        petsAllowed = false
        petsAllAllowed = false
        petsCatsAllowed = false
        petsDogsAllowed = false
        petsRodentsAllowed = false
        petsReptileAllowed = false
        petsBigAnimalAllowed = false
        smokingAllowed = false
        additionalRules = false
        additionalRulesDescription = ""
        checkInAfter = ""
        checkOutBefore = ""
    }
    
    func setOwnerID(_ ownerID: String) -> Self {
        self.ownerID = ownerID
        
        return self
    }
    
    func setStatus(_ status: String) -> Self {
        self.status = status
        
        return self
    }
    
    func setName(from viewModel: FacilityNameViewModel) -> Self {
        self.englishName = viewModel.englishName
        self.arabicName = viewModel.arabicName
        
        return self
    }
    
    func setRoomsData(from viewModel: FacilityRoomsViewModel) -> Self? {
        guard let width = Int(viewModel.facilityWidth), let length = Int(viewModel.facilityLength) else {
            return nil
        }
        self.length = length
        self.width = width
        self.noOfShowers = viewModel.showersCount
        self.noOfBathRooms = viewModel.bathroomsCount
        self.capacity = viewModel.personCapacity
        
        return self
    }
    
    func setRules(from viewModel: FacilityRulesViewModel) -> Self {
        self.petsAllowed = viewModel.petsAllowed
        self.petsAllAllowed = viewModel.allPetsAllowed
        self.petsCatsAllowed = viewModel.cats
        self.petsDogsAllowed = viewModel.dogs
        self.petsRodentsAllowed = viewModel.rodents
        self.petsReptileAllowed = viewModel.reptile
        self.petsBigAnimalAllowed = viewModel.bigAnimals
        self.smokingAllowed = viewModel.allowedToSmoke
        self.additionalRules = viewModel.additonalRules
        self.additionalRulesDescription = viewModel.additionalRulesDescription
        
        return self
    }
    
    func setAmenities(from viewModel: FacilityAmenitiesViewModel) -> Self {
        self.garden = viewModel.garden
        self.playingField = viewModel.playingField
        self.gym = viewModel.gym
        self.outdoorSitting = viewModel.outdoorSitting
        self.bbqArea = viewModel.bbq
        
        return self
    }
    
    func setAddress(from viewModel: FacilityLocationViewModel) -> Self {
        self.address = viewModel.street
        self.city = viewModel.city
        self.latitude = viewModel.latitude
        self.longitude = viewModel.longitude
        
        return self
    }
    
    func setCheckInTime(from viewModel: CheckInCheckOutViewModel) -> Self {
        self.checkInAfter = viewModel.checkInTime
        self.checkOutBefore = viewModel.checkOutTime
        
        return self
    }
    
    func setPrice(from viewModel: FacilityPriceViewModel) -> Self? {
        
        guard let price = Int(viewModel.pricePerNight), let deposit = Int(viewModel.deposit) else {
            return nil
        }
        self.price = price
        self.deposit = deposit
        
        return self
    }
    
    func setDescription(from viewModel: FacilityDescriptionViewModel) -> Self {
        self.facilityDescription = viewModel.description
        
        return self
    }
    
    func build() -> Facility {
        return Facility(id: nil, arabicName: self.arabicName, englishName: self.englishName, facilityDescription: self.facilityDescription, facilityType: self.facilityType, ownerID: self.ownerID, price: self.price, country: self.country, address: self.address, city: self.city, latitude: self.latitude, cancellationPolicyID: self.cancellationPolicyID, length: self.length, width: self.width, capacity: self.capacity, noOfBathRooms: self.noOfBathRooms, noOfShowers: self.noOfShowers, feePercentage: self.feePercentage, status: self.status, garden: self.garden, playingField: self.playingField, gym: self.gym, outdoorSitting: self.outdoorSitting, bbqArea: self.bbqArea, petsAllowed: self.petsAllowed, petsAllAllowed: self.petsAllowed, petsCatsAllowed: self.petsCatsAllowed, petsDogsAllowed: self.petsDogsAllowed, petsRodentsAllowed: self.petsRodentsAllowed, petsReptileAllowed: self.petsReptileAllowed, petsBigAnimalAllowed: self.petsBigAnimalAllowed, smokingAllowed: self.smokingAllowed, additionalRules: self.additionalRules, additionalRulesDescription: self.additionalRulesDescription, longitude: self.longitude, checkInAfter: self.checkInAfter, checkInBefore: "12:00 PM", checkOutBefore: self.checkOutBefore, deposit: self.deposit, nameStatus: 1, roomsStatus: 1, amenityFreeStatus: 1, amenityExtraStatus: 1, rulesStatus: 1, photoStatus: 0, locationStatus: 1, checkInOutStatus: 1, priceStatus: 1, descriptionStatus: 1)
    }
}
