//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation
import CoreLocation

class AddNewUnitViewModel: ObservableObject {
    
    //MARK: - Usecase
    
    private let createFacilityUseCase: CreateFacilityUseCase
    
    
    //MARK: - Properties
    
    
    
    //MARK: - Navigation indicators
    
    @Published var willShowAddRoomsScreen: Bool = false
    @Published var willShowFreeAmenitiesScreen: Bool = false
    @Published var willShowPaidAmenitiesScreen: Bool = false
    @Published var willShowRulesScreen: Bool = false
    @Published var willShowLocationScreen: Bool = false
    @Published var willShowMapScreen: Bool = false
    @Published var willShowCheckInScreen: Bool = false
    @Published var willShowPriceSetupScreen: Bool = false
    @Published var willShowDescriptionScreen: Bool = false
    @Published var willShowPhotosScreen: Bool = false
    
    private let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
    @Published var facilityName: String = ""
    @Published var isValidEnglishName: Bool = true
    @Published var isValidArabicName: Bool = true
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
    
    
    //MARK: - Step - 3
    
    func validateFreeAmenities() {
        willShowPaidAmenitiesScreen = true
        //        self.objectWillChange.send()
        //        if facility.hasValidFreeAmenities() {
        //            print("Valid free amenity")
        //            let data = facility.prepareFreeServicesRequestBody()
        //
        //            createFacilityUseCase.updateFacility(for: .stepThree, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(let error):
        //                    print("error \(error)")
        //
        //                case .success(let success):
        //                    print("success \(success)")
        //                    DispatchQueue.main.async {
        //                        self?.willShowPaidAmenitiesScreen = true
        //                    }
        //                }
        //            }
        //
        //        } else {
        //            print("Invalid free amenity")
        //        }
    }
    
    
    //MARK: - Step - 4
    
    func validatePaidAmenities(){
        //        facility.paidAmenities.validateWifiPrice()
        //        facility.paidAmenities.validateParkingPrice()
        if facility.hasValidPaidAmenities() {
            print("Valid paid")
            let data = facility.preparePaidServicesRequestBody()
            
            createFacilityUseCase.updateFacility(for: .stepFour, with: data) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                    
                case .success(let success):
                    print("success \(success)")
                    DispatchQueue.main.async {
                        self?.willShowRulesScreen = true
                    }
                }
            }
            
        } else {
            print("Invalid paid amenity")
        }
        self.objectWillChange.send()
    }
    
    
    //MARK: - Step-5
    
    func updateFacilityRules() {
        willShowLocationScreen.toggle()
        //        let data = facility.prepareRulesRequestBody()
        //
        //        createFacilityUseCase.updateFacility(for: .stepFive, with: data) { [weak self] result in
        //            switch result {
        //            case .failure(let error):
        //                print("error \(error)")
        //
        //            case .success(let success):
        //                print("success \(success)")
        //                DispatchQueue.main.async {
        //                    self?.willShowLocationScreen = true
        //                }
        //            }
        //        }
    }
    
    
    //MARK: - Step-6.1
    // Note: This is step-6 because photos selection has been moved last step.
    func validateAddress() {
        willShowMapScreen = facility.hasValidAddress()
    }
    
    
    //MARK: - Step-6.2
    func updateFacilityLocation(with coordinates: CLLocationCoordinate2D) {
        willShowCheckInScreen = true
        //        facility.location.latitude = coordinates.latitude
        //        facility.location.longitude = coordinates.longitude
        //
        //        let data = facility.prepareLocationRequestBody()
        //        print("loc --> \(data)")
        //        createFacilityUseCase.updateFacility(for: .stepSix, with: data) { [weak self] result in
        //            switch result {
        //            case .failure(let error):
        //                print("error \(error)")
        //
        //            case .success(let success):
        //                print("success \(success)")
        //                DispatchQueue.main.async {
        //                    self?.willShowCheckInScreen = true
        //                }
        //            }
        //        }
    }
    
    
    //MARK: - Step-7
    func validateCheckInCheckOutTimings() {
        willShowPriceSetupScreen = true
        //        if facility.hasValidCheckInTime() {
        //
        //            let data = facility.prepareCheckInTimeRequestBody()
        //
        //            createFacilityUseCase.updateFacility(for: .stepSeven, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(let error):
        //                    print("error \(error)")
        //
        //                case .success(let success):
        //                    print("success \(success)")
        //                    DispatchQueue.main.async {
        //                        self?.willShowPriceSetupScreen = true
        //                    }
        //                }
        //            }
        //            willShowPriceSetupScreen = true //Don't forget to remove this
        //        }
    }
    
    
    //MARK: - Step-8
    func validateFaciltyPrice(){
        willShowDescriptionScreen = true
//        if facility.hasValidPrice() {
//            print("Valid price")
//            let data = facility.preparePriceRequestBody()
//            
//            createFacilityUseCase.updateFacility(for: .stepEight, with: data) { [weak self] result in
//                switch result {
//                case .failure(let error):
//                    print("error \(error)")
//                    
//                case .success(let success):
//                    print("success \(success)")
//                    DispatchQueue.main.async {
//                        self?.willShowDescriptionScreen = true
//                    }
//                }
//            }
//        } else {
//            print("invalid price")
//        }
    }
    
    
    //MARK: - Step-9
    func onContineDescription(){
        
        willShowPhotosScreen = true 
//        let data = facility.prepareDescriptionRequestBody()
//
//        createFacilityUseCase.updateFacility(for: .stepNine, with: data) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print("error \(error)")
//
//            case .success(let success):
//                print("success description \(success)")
//                DispatchQueue.main.async {
//                    self?.willShowPhotosScreen = true
//                }
//            }
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
    
    //MARK: - Add paid Indoor swimming pool
    func addPaidIndoorSwimmingPool(){
        facility.paidAmenities.addPool(.indoor)
        //self.objectWillChange.send()
    }
    
    
    //MARK: - Remove paid Indoor swimming pool
    func removePaidIndoorSwimmingPool(){
        facility.paidAmenities.removePool(.indoor)
    }
    
    //MARK: - Add paid Outdoor swimming pool
    func addPaidOutdoorSwimmingPool(){
        facility.paidAmenities.addPool(.outdoor)
        //self.objectWillChange.send()
    }
    
    
    //MARK: - Remove paid Outdoor swimming pool
    func removePaidOutdoorSwimmingPool(){
        facility.paidAmenities.removePool(.outdoor)
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
    
    
    @Published var data = Data()
    
    func getImg() {
        createFacilityUseCase.getImage { result in
            switch result {
            case .success(let daata):
                DispatchQueue.main.async {
                    self.data = daata
                }
                
            case .failure(_):
                print("fail")
            }
        }
    }
}


enum FacilityCreationStep {
    //case one
    case stepTwo
    case stepThree
    case stepFour
    case stepFive
    case stepSix
    case stepSeven
    case stepEight
    case stepNine
    case stepTen
}
