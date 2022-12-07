//
//  Location.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/08/2022.
//

import Foundation

struct Location {
    var country: String = "Saudi Arabia"
    var city: String = ""
    var validCity: Bool = true
    var street: String = ""
    var validStreet: Bool = true
    var longitude: Double = 45.0792 
    var latitude: Double = 23.8859
    var isAddressValid: Bool {
        return validCity && validStreet
    }
    
    
    /// Checks whether the user has entered a valid address of the facilty.
    /// - Returns: True if the city and street is valid. False otherwise.
    
    mutating func validateAddress() {
        if isValidAddress(city) && isValidAddress(street) {
            mutateValidity(of: &validCity, to: true)
            mutateValidity(of: &validStreet, to: true)
        } else {
            mutateValidity(of: &validCity, to: false)
            mutateValidity(of: &validStreet, to: false)
        }
    }
    
    mutating func validAddress() -> Bool {
        mutateValidity(of: city, &validCity)
        mutateValidity(of: street, &validStreet)
        
        return validCity && validStreet
    }
    
    mutating func updateCoordinates(with lat: Double, and lon: Double){
        latitude = lat
        longitude = lon
    }
    
    
    func toRequestBodyModel() -> FacilityLocationRequestBody {
        return FacilityLocationRequestBody(country: self.country, city: self.city, address: self.street, latitude: self.latitude, longitude: self.longitude)
    }
    
    
    /// Checks if the address is empty or has less than 3 characters and mutate the validity of address.
    /// - Parameters:
    ///   - address: Address of the facility. This could be either city or street.
    ///   - isValid: An indicator for address validity.
    private func mutateValidity(of address: String, _ isValid: inout Bool)  {
        if address.isEmpty || address.count < 3{
            isValid = false
        } else {
            isValid = true
        }
    }
    
    private func mutateValidity(of validityIndicator: inout Bool, to value: Bool) {
        validityIndicator = value
    }
    
    private func isValidAddress(_ address: String) -> Bool {
        if address.isEmpty || address.count < 3 {
            return false
        } else {
            return true
        }
    }
    
    private enum AddressType{
        case city
        case street
    }
    
    enum errors: Error {
        case invalidCity
        case invalidStreetAddress
    }
}

// MARK: - FacilityRulesRequestBody
struct FacilityLocationRequestBody: Codable {
    let country, city, address: String
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case country, city, address, latitude, longitude
    }
}
