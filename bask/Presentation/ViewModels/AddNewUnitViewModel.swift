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
    
    @Published var roomsCount: Int = 0
    
    @Published var rooms: [Int] = []
    
    func isFacilityNameValid(){
        if facilityName.isEmpty || facilityName.count < 3 {
            isValidName = false
        } else {
            isValidName = true
            willShowAddRoomsScreen = true
        }
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
    
}
