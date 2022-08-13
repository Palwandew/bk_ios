//
//  Amenity.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/08/2022.
//

import Foundation

class Amenity: Hashable, Identifiable {
    let id: UUID = UUID()
    var width: String = ""
    var length: String = ""
    var validLength: Bool = true
    var validWidth: Bool = true
    let serviceTypeId: Int
    
    init(serviceTypeId: Int){
        self.serviceTypeId = serviceTypeId
    }
    
    static func == (lhs: Amenity, rhs: Amenity) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            //hasher.combine(name) If userId was not unique, we could have added this.
            
            // And if that still doesn't do it, consider generating a random UUID for
            // each instance and that can serve as the sole hashing property.
        }
}


class AmenityFree: Amenity {
    override init(serviceTypeId: Int) {
        super.init(serviceTypeId: serviceTypeId)
    }
}

class AmenityPaid: Amenity {

    let priceUnit: String = "Day"
    let isFree: Bool = false
    var price: String = ""
    var validPrice: Bool = true 
    var description: String = ""
    let validDescription: Bool = true 
    
    override init(serviceTypeId: Int) {
        super.init(serviceTypeId: serviceTypeId)
    }
}
