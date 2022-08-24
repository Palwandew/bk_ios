//
//  CheckList.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/08/2022.
//

import Foundation

struct Checklist {
    private var nameStatus: Int = 1
    private var roomsStatus: Int = 1
    private var amenityFreeStatus: Int = 1
    private var amenityExtraStatus: Int = 1
    private var rulesStatus: Int = 1
    private var photoStatus: Int = 1
    private var locationStatus: Int = 1
    private var checkInOutStatus: Int = 1
    private var priceStatus: Int = 1
    private var descriptionStatus: Int = 1
    
    
    init(){
        nameStatus = 1
        roomsStatus = 1
        amenityFreeStatus  = 1
        amenityExtraStatus = 1
        rulesStatus = 1
        photoStatus = 1
        locationStatus = 1
        checkInOutStatus = 1
        priceStatus = 1
        descriptionStatus = 1
        
    }
    
    init(_ nameStatus: Int, _ roomStatus: Int,
         _ freeAmenityStatus: Int, _ paidAmenityStatus: Int,
         _ rulesStatus: Int, _ photosStatus: Int, _ locationStatus: Int,
         _ checkInStatus: Int, _ priceStatus: Int,
         _ descriptionStatus: Int){
        self.nameStatus = nameStatus
        self.roomsStatus = roomStatus
        self.amenityFreeStatus = freeAmenityStatus
        self.amenityExtraStatus = paidAmenityStatus
        self.rulesStatus = rulesStatus
        self.photoStatus = photosStatus
        self.locationStatus = locationStatus
        self.checkInOutStatus = checkInStatus
        self.priceStatus = priceStatus
        self.descriptionStatus = descriptionStatus
    }
    
    func getChecklistForView() -> [String: Int] {
        var dictionary = [String: Int]()
        dictionary.updateValue(self.nameStatus, forKey: "Name")
        dictionary.updateValue(self.roomsStatus, forKey: "Rooms")
        dictionary.updateValue(self.amenityFreeStatus, forKey: "Amenities (free)")
        dictionary.updateValue(self.amenityExtraStatus, forKey: "Amenities (with extra money)")
        dictionary.updateValue(self.rulesStatus, forKey: "Rules of house")
        dictionary.updateValue(self.locationStatus, forKey: "Facility location")
        dictionary.updateValue(self.checkInOutStatus, forKey: "Check-in")
        dictionary.updateValue(self.priceStatus, forKey: "Price")
        dictionary.updateValue(self.descriptionStatus, forKey: "Description")
        dictionary.updateValue(self.photoStatus, forKey: "Photos")
        
        return dictionary
    }
}
