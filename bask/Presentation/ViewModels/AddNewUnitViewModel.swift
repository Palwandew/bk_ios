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
    
    func isFacilityNameValid(){
        if facilityName.isEmpty || facilityName.count < 3 {
            isValidName = false
        } else {
            isValidName = true
            willShowAddRoomsScreen = true
        }
    }
    
}
