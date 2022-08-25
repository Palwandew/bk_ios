//
//  CheckList.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 24/08/2022.
//

import Foundation

struct Checklist {
    
    var items: [ChecklistItem] = []
    private let titles: [String] = ["Name", "Rooms", "Amenities", "Amenities (paid)", "Rules of house", "Facility Location", "Check-in", "Price", "Description", "Photos"]
    
    init(){

        for title in titles {
            items.append(ChecklistItem(title: title, status: nil))
        }
        
    }
    
    init(_ nameStatus: Int, _ roomStatus: Int,
         _ freeAmenityStatus: Int, _ paidAmenityStatus: Int,
         _ rulesStatus: Int, _ photosStatus: Int, _ locationStatus: Int,
         _ checkInStatus: Int, _ priceStatus: Int,
         _ descriptionStatus: Int){
        
        items.append(ChecklistItem(title: "Name", status: nameStatus))
        items.append(ChecklistItem(title: "Rooms", status: roomStatus))
        items.append(ChecklistItem(title: "Amenities", status: freeAmenityStatus))
        items.append(ChecklistItem(title: "Amenities (paid)", status: paidAmenityStatus))
        items.append(ChecklistItem(title: "Rules of house", status: rulesStatus))
        items.append(ChecklistItem(title: "Facility Location", status: locationStatus))
        items.append(ChecklistItem(title: "Check-in", status: checkInStatus))
        items.append(ChecklistItem(title: "Price", status: priceStatus))
        items.append(ChecklistItem(title: "Description", status: descriptionStatus))
        items.append(ChecklistItem(title: "Photos", status: photosStatus))
        
    }
}

struct ChecklistItem: Identifiable{
    var id: UUID = UUID()
    
    let title: String
    let status: Int?
}
