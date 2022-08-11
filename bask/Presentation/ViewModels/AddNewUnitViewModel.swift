//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation

class AddNewUnitViewModel: ObservableObject {
    
    //MARK: - Usecase
    
    private let createFacilityUseCase: CreateFacilityUseCase
    
    
    //MARK: - Properties
    
    private let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
    @Published var facilityName: String = ""
    @Published var isValidEnglishName: Bool = true
    @Published var isValidArabicName: Bool = true
    @Published var willShowAddRoomsScreen: Bool = false
    @Published var willShowFreeAmenitiesScreen: Bool = false
    
    @Published var roomsCount: Int = 0
    @Published var kitchenCount: Int = 0
    
    @Published var rooms: [Room] = []
    @Published var kitchen: [Int] = []
    @Published var isValidLength: Bool = true
    @Published var isValidWidth: Bool = true
    @Published var facility: Facility = Facility()
    
    @Published var showAlert: Bool = false 
    
    init(useCase: CreateFacilityUseCase){
        createFacilityUseCase = useCase
    }
    
    //MARK: - Step - 1 Validation
    
    
    func isFacilityNameValid() {
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
    
    
    //MARK: - Step - 2
    
    func onContinueTapped(){
        self.willShowFreeAmenitiesScreen = true 
//        do {
//            try facility.validateArea()
//
//            isValidWidth = true
//            isValidLength = true
//
//            if facility.hasValidLivingRooms() {
//                self.objectWillChange.send()
//
//                //showAlert.toggle()
//
//                let data = facility.prepareRequestBody()
//
//                createFacilityUseCase.updateFacility(for: .stepTwo, with: data) { result  in
//                    switch result {
//                    case .success(let message):
//                        print("Ho hoi ho hoi\(message)")
//                        DispatchQueue.main.async {
//                            //self.showAlert.toggle()
//                            self.willShowFreeAmenitiesScreen = true
//                        }
//
//                    case .failure(let error):
//                        print("\(error)")
//                    }
//                }
//            }
//
//
//        } catch FacilityErrors.invalidWidth {
//            isValidWidth = false
//        } catch FacilityErrors.invalidLength {
//            isValidLength = false
//        } catch FacilityErrors.emptyArea {
//            isValidWidth = false
//            isValidLength = false
//        } catch {
//            print("error")
//        }
    }
    
    func addRoom() {
        
        facility.addRoom()
        
    }
    
    func removeRoom() {
        print("Array size \(rooms.count)")
        facility.removeRoom()
    }
    
    func addIndoorSwimmingPool(){
        facility.addIndoorSwimmingPool()
    }
    
    func removeIndoorSwimmingPool(){
        facility.removeIndoorSwimmingPool()
    }
    
    func addOutdoorSwimmingPool(){
        facility.addOutdoorSwimmingPool()
    }
    
    func removeOutdoorSwimmingPool(){
        facility.removeOutdoorSwimmingPool()
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


enum FacilityCreationStep {
    //case one
    case stepTwo
    //    case three
    //    case fourth
    //    case fifth
    //    case sixth
    //    case seventh
    //    case eight
    //    case ninth
}
