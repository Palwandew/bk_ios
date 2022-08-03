//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation

class AddNewUnitViewModel: ObservableObject {
    
    
    //MARK: - Properties for step - 1
    
    
    @Published var facilityName: String = ""
    @Published var isValidName: Bool = true
    @Published var willShowAddRoomsScreen: Bool = false
    @Published var willShowFreeAmenitiesScreen: Bool = false
    
    @Published var roomsCount: Int = 0
    @Published var kitchenCount: Int = 0
    
    @Published var rooms: [Int] = []
    @Published var kitchen: [Int] = []
    
    @Published var facility: Facility = Facility(kitchen: 0, capacity: 0, bathrooms: 0, showers: 0)
    
    func isFacilityNameValid(){
        if facilityName.isEmpty || facilityName.count < 3 {
            isValidName = false
        } else {
            isValidName = true
            willShowAddRoomsScreen = true
        }
    }
    
    func onContinueTapped(){
        willShowFreeAmenitiesScreen = true
        print("width \(self.facility.width) \n length \(self.facility.length)")
    }
    
    func addRoom() {
        roomsCount += 1
        rooms.append(1)
    }
    
    func removeRoom() {
        
        if !rooms.isEmpty{
            roomsCount -= 1
            rooms.removeLast()
        }
    }
    
    
    //MARK: - Kitchen Counter Manipulation
    func increaseKitchenCount(){
        facility.increaseCounterOf(.kitchen)
    }
    
    func decreaseKitchenCount() {
        facility.decreaseCounterOf(.kitchen)
    }
    
    
    // MARK: - Capacity Counter Manipulation
    func increaseCapacityCount() {
        facility.increaseCounterOf(.capacity)
    }
    
    func decreaseCapacityCount() {
        facility.decreaseCounterOf(.capacity)
    }
    
    
    // MARK: - Bathroom Counter Manipulation
    func increaseBathroomCount() {
        facility.increaseCounterOf(.bathroom)
    }
    
    func decreaseBathroomCount() {
        facility.decreaseCounterOf(.bathroom)
    }
    
    // MARK: - Showers Counter Manipulation
    func increaseShowersCount() {
        facility.increaseCounterOf(.showers)
    }
    
    func decreaseShowersCount() {
        facility.decreaseCounterOf(.showers)
    }
}
