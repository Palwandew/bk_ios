//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation

class AddNewUnitViewModel: ObservableObject {
    
    
    private let createFacilityUseCase: CreateFacilityUseCase
    //MARK: - Properties for step - 1
    
    private let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
    @Published var facilityName: String = ""
    @Published var isValidEnglishName: Bool = true
    @Published var isValidArabicName: Bool = true
    @Published var willShowAddRoomsScreen: Bool = false
    @Published var willShowFreeAmenitiesScreen: Bool = false
    
    @Published var roomsCount: Int = 0
    @Published var kitchenCount: Int = 0
    
    @Published var rooms: [Int] = []
    @Published var kitchen: [Int] = []
    
    @Published var facility: Facility = Facility(kitchen: 0, capacity: 0, bathrooms: 0, showers: 0)
    
    init(useCase: CreateFacilityUseCase){
        createFacilityUseCase = useCase
    }
    
    func isFacilityNameValid(){
        do {
            try facility.validateName()
            isValidEnglishName = true
            isValidArabicName = true
            
            let data = facility.prepareRequestBodyWith(ownerID: ownerId)
            
            do {
                let requestBody = try JSONEncoder().encode(data)
                
                createFacilityUseCase.createFacility(requestBody) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print("\(error)")
                    case .success(let id):
                        print(id)
                        self?.willShowAddRoomsScreen = true 
                    }
                }
            } catch {
                print("error encoding data")
            }
            
            
        
        } catch FacilityErrors.invalidEnglishName {
            print("English name is invalid")
            isValidEnglishName = false
        } catch FacilityErrors.invalidArabicName {
            print("Arabic name is invalid")
        } catch {
            print("some error")
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
