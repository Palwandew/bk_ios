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
    
    @Published var checkList: Checklist = Checklist()
    
    @Published var showToast: Bool = false
    @Published var toastStyle: ToastStyle = .success
    
    
    // Retry button indicator
    @Published var shallRetry: Bool = false
    
    init(useCase: CreateFacilityUseCase){
        createFacilityUseCase = useCase
    }
    
    func urlTesting(){
        let queryItem: [URLQueryItem] = [URLQueryItem(name: "facility", value: "123412")]
        let endPoint = Endpoints(path: "/api/v1/facility", queryItems: queryItem)
        guard let url = endPoint.url else {
            print("invalid url ")
            return
        }
        print(url.absoluteString)
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
                
                let endpoint = Endpoints.CREATE_FACILITY
                
                createFacilityUseCase.createFacility(endpoint, requestBody) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        print("\(error)")
                        DispatchQueue.main.async {
                            self?.shallRetry = true
                        }
                        
                    case .success(let id):
                        print(id)
                        
                        DispatchQueue.main.async {
                            self?.facility.id = id
                            self?.shallRetry = false
                            self?.willShowAddRoomsScreen = true
                        }
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
            isValidArabicName = false
        } catch {
            print("some error")
        }
    }
    
    
    //MARK: - Step - 2
    
    func onContinueTapped(){
        
        do {
            try facility.validateArea()
            
            isValidWidth = true
            isValidLength = true
            
            if facility.hasValidLivingRooms() {
                self.objectWillChange.send()
                
                //showAlert.toggle()
                
                let data = facility.prepareRequestBody()
                
                guard let facilityId = facility.id else {
                    return
                }
                
                let endpoint = Endpoints.UPDATE_FACILITY(facilityId)
                
                
                createFacilityUseCase.updateFacilityArea(endpoint, with: data) { [weak self] result  in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(_):
                            
                            //self.showAlert.toggle()
                            self?.shallRetry = false
                            self?.willShowFreeAmenitiesScreen = true
                            
                            
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                            
                            self?.shallRetry = true
                            
                        }
                    }
                    
                }
                
            }
            
            
        } catch FacilityErrors.invalidWidth {
            isValidWidth = false
        } catch FacilityErrors.invalidLength {
            isValidLength = false
        } catch FacilityErrors.emptyArea {
            isValidWidth = false
            isValidLength = false
        } catch {
            print("error")
        }
    }
    
    
    //MARK: - Step - 3
    
    func validateFreeAmenities() {
        
        self.objectWillChange.send()
        if facility.hasValidFreeAmenities() {
            
            let data = facility.prepareFreeServicesRequestBody()
            
            createFacilityUseCase.updateFacility(for: .stepThree, with: data) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                    DispatchQueue.main.async {
                        self?.shallRetry = true
                    }
                    
                case .success(let success):
                    print("success \(success)")
                    DispatchQueue.main.async {
                        self?.shallRetry = false
                        self?.willShowPaidAmenitiesScreen = true
                    }
                }
            }
            
        } else {
            print("Invalid free amenity")
        }
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
                    DispatchQueue.main.async {
                        self?.shallRetry = true
                    }
                    
                case .success(let success):
                    print("success \(success)")
                    DispatchQueue.main.async {
                        self?.shallRetry = false
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
        let data = facility.prepareRulesRequestBody()
        
        createFacilityUseCase.updateFacility(for: .stepFive, with: data) { [weak self] result in
            switch result {
            case .failure(let error):
                print("error \(error)")
                DispatchQueue.main.async {
                    self?.shallRetry = true
                }
                
            case .success(let success):
                print("success \(success)")
                DispatchQueue.main.async {
                    self?.shallRetry = false
                    self?.willShowLocationScreen = true
                }
            }
        }
    }
    
    
    //MARK: - Step-6.1
    // Note: This is step-6 because photos selection has been moved last step.
    func validateAddress() {
        willShowMapScreen = facility.hasValidAddress()
    }
    
    
    //MARK: - Step-6.2
    func updateFacilityLocation(with coordinates: CLLocationCoordinate2D) {
        
        facility.location.latitude = coordinates.latitude
        facility.location.longitude = coordinates.longitude
        
        let data = facility.prepareLocationRequestBody()
        print("loc --> \(data)")
        createFacilityUseCase.updateFacility(for: .stepSix, with: data) { [weak self] result in
            switch result {
            case .failure(let error):
                print("error \(error)")
                DispatchQueue.main.async {
                    self?.shallRetry = true
                }
                
            case .success(let success):
                print("success \(success)")
                DispatchQueue.main.async {
                    self?.shallRetry = false
                    self?.willShowCheckInScreen = true
                }
            }
        }
    }
    
    
    //MARK: - Step-7
    func validateCheckInCheckOutTimings() {
        
        if facility.hasValidCheckInTime() {
            
            let data = facility.prepareCheckInTimeRequestBody()
            
            createFacilityUseCase.updateFacility(for: .stepSeven, with: data) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("error \(error)")
                    DispatchQueue.main.async {
                        self?.shallRetry = true
                    }
                    
                case .success(let success):
                    print("success \(success)")
                    DispatchQueue.main.async {
                        self?.shallRetry = false
                        self?.willShowPriceSetupScreen = true
                    }
                }
            }
        }
    }
    
    
    //MARK: - Step-8
    func validateFaciltyPrice(){
        
        if facility.hasValidPrice() {
            
            let data = facility.preparePriceRequestBody()
            
            createFacilityUseCase.updateFacility(for: .stepEight, with: data) { [weak self] result in
                switch result {
                case .failure(_):
                    
                    DispatchQueue.main.async {
                        self?.shallRetry = true
                    }
                    
                case .success(_):
                    
                    DispatchQueue.main.async {
                        self?.shallRetry = false
                        self?.willShowDescriptionScreen = true
                    }
                }
            }
        } else {
            print("invalid price")
        }
    }
    
    
    //MARK: - Step-9
    func onContineDescription(){
        
        
        let data = facility.prepareDescriptionRequestBody()
        
        createFacilityUseCase.updateFacility(for: .stepNine, with: data) { [weak self] result in
            switch result {
            case .failure(_):
                
                DispatchQueue.main.async {
                    self?.shallRetry = true
                }
                
            case .success(_):
                
                DispatchQueue.main.async {
                    self?.shallRetry = false
                    self?.willShowPhotosScreen = true
                }
            }
        }
    }
    
    
    //MARK: - Step-10
    func getChecklist() {
        createFacilityUseCase.getChecklist { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    
                case .failure(_):
                    
                    DispatchQueue.main.async {
                        self?.shallRetry = true
                    }
                    
                case .success(let checkList):
                    
                    DispatchQueue.main.async {
                        self?.shallRetry = false
                        self?.checkList = checkList
                    }
                }
            }
        }
    }
    
    
    //MARK: - Step-11-A
    func publishFacility(){
        createFacilityUseCase.publishFacility { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.shallRetry = true
                    self.toastStyle = .success
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    UIApplicationHelper.popToRootView()
                }
            case .failure(_):
                
                DispatchQueue.main.async {
                    self.shallRetry = true
                    self.toastStyle = .failure
                }
                
            }
        }
    }
    
    
    //MARK: - Step-11-B
    func saveFacilityUnpublished(){
        self.showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIApplicationHelper.popToRootView()
        }
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


struct Endpoints{
    private let apiVersion = "/api/v1/"
    let path: String
    let queryItems: [URLQueryItem]?
}


extension Endpoints{
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.baskapp.co"
        components.path = apiVersion + path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoints{
    
    static let CREATE_FACILITY: Endpoints = Endpoints(path: "facility", queryItems: nil)
    
    static func UPDATE_FACILITY(_ facilityID: String) -> Endpoints {
        return Endpoints(path: "facility/\(facilityID)", queryItems: nil)
    }
}
