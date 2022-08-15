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
    var wifiService: AmenityPaid = AmenityPaid(serviceTypeId: 3)//3
    var parking: Bool = false
    var parkingService: AmenityPaid = AmenityPaid(serviceTypeId: 4)//4
    var indoorSwimmingPools: [AmenityPaid] = []//5
    var outdoorSwimmingPools: [AmenityPaid] = []//6
    var indoorPools: Int = 0
    var outdoorPools: Int = 0
    var pets: Bool = false
    var cats: Bool = false//8
    var catsService: AmenityPaid = AmenityPaid(serviceTypeId: 8)
    var dogs: Bool = false//9
    var dogsService: AmenityPaid = AmenityPaid(serviceTypeId: 9)
    var rodents: Bool = false//10
    var rodentsService: AmenityPaid = AmenityPaid(serviceTypeId: 10)
    var reptiles: Bool = false//11
    var reptilesService: AmenityPaid = AmenityPaid(serviceTypeId: 11)
    var bigAnimals: Bool = false//12
    var bigAnimalsService: AmenityPaid = AmenityPaid(serviceTypeId: 12)
    
    
    //MARK: - Wifi price validation
    
    private func validWifi() -> Bool {
        return isPriceAdded(wifi, for: wifiService)
    }
    
    
    //MARK: - Parking price validation
    
    private func validParking() -> Bool {
        return isPriceAdded(parking, for: parkingService)
    }
    
    
    //MARK: - Validate swimming pools
    
    private func validPools(_ type: SwimmingPool) -> Bool {
        
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
    
    
    //MARK: - Validate pets
    
    private func validPets() -> Bool {
       
        return isPriceAdded(cats, for: catsService) &&
        isPriceAdded(dogs, for: dogsService) &&
        isPriceAdded(rodents, for: rodentsService) &&
        isPriceAdded(reptiles, for: reptilesService) &&
        isPriceAdded(bigAnimals, for: bigAnimalsService)
      
    }
    
    
    /// Checks the price of amenity, if the amenity has been selected as paid.
    /// - Parameters:
    ///   - willAddToServices: Indicator if this amenity has been selected by the user.
    ///   - amenity: Facility Amenity.
    /// - Returns: Default return value is True, since there is no need to check the price for a amenity if it is not selected by the user.
    /// Otherwise, will return the appropiate value based on the price input.
    private func isPriceAdded(_ willAddToServices: Bool, for amenity: AmenityPaid) -> Bool {
        if willAddToServices {
            if amenity.price.isEmpty {
                amenity.validPrice = false
            } else {
                amenity.validPrice = true
            }
            return amenity.validPrice
        } else {
            return true
        }

    }
    
    
    /// Checks if the paid services of the facility have price added.
    /// - Returns: True if all the services have price included, False otherwise.
    func valid() -> Bool {
        return validWifi() && validParking() && validPools(.indoor) && validPools(.outdoor) && validPets()
        
    }
    private enum Pet {
        case cat, dog, rodent, reptile, bigAnimal
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
    
    
    //MARK: - Request Body Preparation
    
    func preparePaidServices(for facilityID: String) -> [FacilityPaidService] {
        var services: [FacilityPaidService] = []
        
        if wifi {
            let wifi = generatePaidService(for: facilityID, with: wifiService)
            services.append(wifi)
        }
        
        if parking {
            let parking = generatePaidService(for: facilityID, with: parkingService)
            
            services.append(parking)
        }
        
        if !indoorSwimmingPools.isEmpty {
            for indoorPool in indoorSwimmingPools {
                
                let paidIndoorPool = FacilityPaidService(length: Int(indoorPool.length), width: Int(indoorPool.width), serviceTypeID: indoorPool.serviceTypeId, price: Int(indoorPool.price)!, facilityID: facilityID, facilityserviceDescription: indoorPool.description, priceUnit: indoorPool.priceUnit)
                
                services.append(paidIndoorPool)
            }
            
        }
        
        if !outdoorSwimmingPools.isEmpty {
            for outdoorPool in outdoorSwimmingPools {
                
                let paidOutdoorPool = FacilityPaidService(length: Int(outdoorPool.length), width: Int(outdoorPool.width), serviceTypeID: outdoorPool.serviceTypeId, price: Int(outdoorPool.price)!, facilityID: facilityID, facilityserviceDescription: outdoorPool.description, priceUnit: outdoorPool.priceUnit)
                
                services.append(paidOutdoorPool)
            }
        }
        
        if cats {
            let cat = generatePaidService(for: facilityID, with: catsService)
            
            services.append(cat)
        }
        
        if dogs {
            let dog = generatePaidService(for: facilityID, with: dogsService)
            
            services.append(dog)
        }
        
        if rodents {
            let rodent = generatePaidService(for: facilityID, with: rodentsService)
            
            services.append(rodent)
        }
        
        if reptiles {
            let reptile = generatePaidService(for: facilityID, with: reptilesService)
            
            services.append(reptile)
        }
        
        if bigAnimals {
            let bigAnimal = generatePaidService(for: facilityID, with: bigAnimalsService)
            
            services.append(bigAnimal)
        }
        
        return services
    }
    
    private func generatePaidService(for facilityID: String, with amenity: AmenityPaid) -> FacilityPaidService {
        let service = FacilityPaidService(length: nil, width: nil, serviceTypeID: amenity.serviceTypeId, price: Int(amenity.price)!, facilityID: facilityID, facilityserviceDescription: amenity.description, priceUnit: amenity.priceUnit)
        
        return service
    }
    
}

enum SwimmingPool{
    case indoor
    case outdoor
}


// MARK: - FacilityPaidAmenitiesRequestBody
struct FacilityPaidAmenitiesRequestBody: Codable {
    let facilityservices: [FacilityPaidService]
    let facilityID: String

    enum CodingKeys: String, CodingKey {
        case facilityservices
        case facilityID = "facilityId"
    }
}

// MARK: - Facilityservice
struct FacilityPaidService: Codable {
    let isFree: Bool = false
    let length: Int?
    let width: Int?
    let serviceTypeID, price: Int
    let facilityID: String
    //let width: Int
    let facilityserviceDescription, priceUnit: String

    enum CodingKeys: String, CodingKey {
        case isFree, length
        case serviceTypeID = "serviceTypeId"
        case price
        case facilityID = "facilityId"
        case width
        case facilityserviceDescription = "description"
        case priceUnit
    }
}
