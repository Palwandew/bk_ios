//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation
import CoreLocation


class FacilityNameViewModel: ObservableObject {
    
    var englishName: String = ""
    var arabicName: String = ""
    var englishNameError: Bool = false
    var arabicNameError: Bool = false
    var shallNavigate: Bool = false
    
    func onContinueTapped() {
        
            do {
                try validateFacilityName()
                navigateToNextScreen()
                
            } catch FacilityNameErrors.emptyEnglishName {
                englishNameError = true
            } catch FacilityNameErrors.invalidEnglishName {
                englishNameError = true
            } catch FacilityNameErrors.emptyArabicName {
                arabicNameError = true
            } catch FacilityNameErrors.invalidArabicName {
                arabicNameError = true 
            } catch {
                print("Unexpected error occurred \(error)")
            }
        
    }
    
    func navigateToNextScreen(){
        shallNavigate = true
    }
    
    private func validateFacilityName() throws {
        if englishName.isEmpty {
            throw FacilityNameErrors.emptyEnglishName
        }
        if arabicName.isEmpty {
            throw FacilityNameErrors.emptyArabicName
        }
        if englishName.count < 3 {
            throw FacilityNameErrors.invalidEnglishName
        }
        if arabicName.count < 3 {
            throw FacilityNameErrors.invalidArabicName
        }
    }
}

enum FacilityNameErrors: Error{
    case emptyEnglishName
    case invalidEnglishName
    case emptyArabicName
    case invalidArabicName
}

class FacilityRoomsViewModel: ObservableObject {
    var facilityWidth: String = ""
    var facilityLength: String = ""
    var livingRoomsCount: Int = 0
    var kitchensCount: Int = 0
    var bathroomsCount: Int = 0
    var showersCount: Int = 0
    var personCapacity: Int = 0
    var validWidth: Bool = true
    var validLength: Bool = true 
    var shallNavigate: Bool = false
    var toast: ToastViewModel = ToastViewModel()
    
    func onContinueTapped(){
        do {
            try validateFacilitySizeAndRooms()
            navigateToNextScreen()
        } catch FacilityRoomsError.NoLivingRoomsAdded {
            showErrorToast(with: "Your facility must have at least one bed room.")
            
        } catch FacilityRoomsError.CapacityIsZero {
            showErrorToast(with: "Your facility must be able to host one person.")
            
        } catch FacilityRoomsError.EmptySize{
            validWidth = false
            validLength = false
        } catch {
            print("Unknow Error Occured")
        }
    }
    
    private func showErrorToast(with message: String){
        toast.prepare(for: .failure, with: message)
        toast.show()
    }
    
    private func navigateToNextScreen(){
        shallNavigate = true
    }
    
    func increaseCount(of counter: Counter){
        switch counter {
        case .kitchen:
            addCount(of: &kitchensCount)
        case .personCapacity:
            addCount(of: &personCapacity)
        case .bathroom:
            addCount(of: &bathroomsCount)
        case .shower:
            addCount(of: &showersCount)
        case .livingRoom:
            addCount(of: &livingRoomsCount)
        }
    }
    
    func decreaseCount(of counter: Counter){
        switch counter {
        case .livingRoom:
            decreaseCount(of: &livingRoomsCount)
        case .kitchen:
            decreaseCount(of: &kitchensCount)
        case .personCapacity:
            decreaseCount(of: &personCapacity)
        case .bathroom:
            decreaseCount(of: &bathroomsCount)
        case .shower:
            decreaseCount(of: &showersCount)
        }
    }
    
    private func addCount(of counter: inout Int){
        counter += 1
    }
    
    private func decreaseCount( of counter: inout Int){
        if counter >= 1 {
            counter -= 1
        }
    }
    
    
    private func validateFacilitySizeAndRooms() throws {
        if (facilityWidth.isEmpty && facilityLength.isEmpty) {
            throw FacilityRoomsError.EmptySize
        }
        if facilityWidth.isEmpty {
            throw FacilityRoomsError.EmptyWidth
        }
        if facilityLength.isEmpty {
            throw FacilityRoomsError.EmptyLength
        }
        
        if livingRoomsCount == 0 {
            throw FacilityRoomsError.NoLivingRoomsAdded
        }
        
        if personCapacity == 0 {
            throw FacilityRoomsError.CapacityIsZero
        }
    }
    
    enum Counter {
        case livingRoom
        case kitchen
        case bathroom
        case shower
        case personCapacity
    }
    
    enum FacilityRoomsError: Error {
        case EmptySize
        case EmptyLength
        case EmptyWidth
        case NoLivingRoomsAdded
        case CapacityIsZero
    }
}

class FacilityAmenitiesViewModel: ObservableObject {
    var wifi: Bool = false
    var parking: Bool = false
    var indoorPool: Bool = false
    var outdoorPool: Bool = false
    var outdoorSitting: Bool = false
    var bbq: Bool = false
    var gym: Bool = false
    var gamesRoom: Bool = false
    var garden: Bool = false
    var playingField: Bool = false
}

class FacilityRulesViewModel: ObservableObject{
    var petsAllowed: Bool = true
    var allPetsAllowed: Bool = false
    var cats: Bool = true
    var dogs: Bool = false
    var rodents: Bool = false
    var reptile: Bool = false
    var bigAnimals: Bool = false
    var allowedToSmoke: Bool = true
    var additonalRules: Bool = false
    var additionalRulesDescription: String = ""
}

class FacilityLocationViewModel: ObservableObject{
    
    var location: Location = Location()
    var shallNavigate: Bool = false
    var shallShowMap: Bool = false
    
    func onContinueTapped(){
        if location.validAddress() {
            shallShowMap = true
        }
    }
    
    func updateMapPin(with mapCenter : CLLocationCoordinate2D) {
        location.updateCoordinates(with: mapCenter.latitude, and: mapCenter.longitude)
        shallNavigate = true
    }
}

class CheckInCheckOutViewModel: ObservableObject {
    var checkInTime: String = ""
    var checkOutTime: String = ""
    
    func updateTime(){
        checkInTime = "10:00 MP"
        self.objectWillChange.send()
    }
    
}

class FacilityPriceViewModel: ObservableObject {
    var pricePerNight: String = ""
    var deposit: String = ""
    
    func validateFacilityPrice(){
        
    }
}

class FacilityDescriptionViewModel: ObservableObject {
    @Published var description: String = ""
}





class AddNewUnitViewModel: ObservableObject {
    
    private let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
    //MARK: - Usecase
    
    private let createFacilityUseCase: CreateFacilityUseCase
    
    
    //MARK: - Properties
    
    private var creationProcess: FacilityCreationProcess = .new
    
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
    
    @Published var title: String = "Name of facility"
    
    @Published var facilityNameViewModel: FacilityNameViewModel = FacilityNameViewModel()
    @Published var facilityRoomsViewModel: FacilityRoomsViewModel = FacilityRoomsViewModel()
    @Published var facilityAmenitiesViewModel: FacilityAmenitiesViewModel = FacilityAmenitiesViewModel()
    @Published var facilityRulesViewModel: FacilityRulesViewModel = FacilityRulesViewModel()
    @Published var facilityLocationViewModel: FacilityLocationViewModel = FacilityLocationViewModel()
    @Published var checkInCheckOutViewModel: CheckInCheckOutViewModel = CheckInCheckOutViewModel()
    @Published var facilityPriceViewModel: FacilityPriceViewModel = FacilityPriceViewModel()
    
    
    @Published var facilityDescriptionViewModel: FacilityDescriptionViewModel = FacilityDescriptionViewModel()
    // Retry button indicator
    @Published var shallRetry: Bool = false
    
    init(useCase: CreateFacilityUseCase){
        print("Init create new facility view model")
        createFacilityUseCase = useCase
    }
    
    deinit{
        print("deinit create new facility view model")
    }
    
    
    func onContinueTapped(nextStep: FacilityCreationState){
        performAction(for: nextStep)
    }
    
    func onBackTapped(previousStep: FacilityCreationState){
        performAction(for: previousStep)
    }
    
    private func performAction(for state: FacilityCreationState){
        switch state {
        case .name:
            updateTitle(with: "Name of facility")
        case .amenities:
            updateTitle(with: "Amenities")
        case .rules:
            updateTitle(with: "Rules")
        case .address:
            updateTitle(with: "Address")
        case .rooms:
            updateTitle(with: "Rooms")
        case .map:
            updateTitle(with: "Location")
        case .checkInTime:
            updateTitle(with: "Set timings")
        case .price:
            updateTitle(with: "Price")
        case .description:
            updateTitle(with: "Describe your facility")
        }
    }
    
    private func updateTitle(with newTitle: String){
        title = newTitle
    }
    
    
    //MARK: - Step - 1 Validation
    
    
    func isFacilityNameValid() {
        facilityNameViewModel.onContinueTapped()
        
        //        willShowAddRoomsScreen = true
        //        do {
        //            try facility.validateName()
        //            isValidEnglishName = true
        //            isValidArabicName = true
        //
        //            let data = facility.prepareRequestBodyWith(ownerID: ownerId)
        //
        //            do {
        //
        //                let requestBody = try JSONEncoder().encode(data)
        //
        //                let endpoint = Endpoints.CREATE_FACILITY
        //
        //                createFacilityUseCase.createFacility(endpoint, requestBody) { [weak self] result in
        //                    switch result {
        //                    case .failure(let error):
        //                        print("\(error)")
        //                        DispatchQueue.main.async {
        //                            self?.shallRetry = true
        //                        }
        //
        //                    case .success(let id):
        //                        print(id)
        //
        //                        DispatchQueue.main.async {
        //                            self?.facility.id = id
        //                            self?.shallRetry = false
        //                            self?.willShowAddRoomsScreen = true
        //                        }
        //                    }
        //                }
        //            } catch {
        //                print("error encoding data")
        //            }
        //
        //
        //
        //        } catch FacilityErrors.invalidEnglishName {
        //            print("English name is invalid")
        //            isValidEnglishName = false
        //        } catch FacilityErrors.invalidArabicName {
        //            print("Arabic name is invalid")
        //            isValidArabicName = false
        //        } catch {
        //            print("some error")
        //        }
    }
    
    
    //MARK: - Step - 2
    
    func onContinueTapped(){
        facilityRoomsViewModel.onContinueTapped()
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
        //                guard let facilityId = facility.id else {
        //                    return
        //                }
        //
        //                let endpoint = Endpoints.UPDATE_FACILITY(facilityId)
        //
        //
        //                createFacilityUseCase.updateFacilityArea(endpoint, with: data) { [weak self] result  in
        //
        //                    DispatchQueue.main.async {
        //                        switch result {
        //                        case .success(_):
        //
        //                            //self.showAlert.toggle()
        //                            self?.shallRetry = false
        //                            self?.willShowFreeAmenitiesScreen = true
        //
        //
        //                        case .failure(let error):
        //                            print("\(error.localizedDescription)")
        //
        //                            self?.shallRetry = true
        //
        //                        }
        //                    }
        //
        //                }
        //
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
    
    func increaseCount(of counter: FacilityRoomsViewModel.Counter){
        facilityRoomsViewModel.increaseCount(of: counter)
    }
    
    func decreaseCount(of counter: FacilityRoomsViewModel.Counter){
        facilityRoomsViewModel.decreaseCount(of: counter)
    }
    
    
    //MARK: - Step - 3
    
    func validateFreeAmenities() {
        willShowPaidAmenitiesScreen = true
        //        self.objectWillChange.send()
        //        if facility.hasValidFreeAmenities() {
        //
        //            let data = facility.prepareFreeServicesRequestBody()
        //
        //            createFacilityUseCase.updateFacility(with: facility.id, for: .stepThree, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(let error):
        //                    print("error \(error)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = true
        //                    }
        //
        //                case .success(let success):
        //                    print("success \(success)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = false
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
        willShowRulesScreen = true
        //        if facility.hasValidPaidAmenities() {
        //            print("Valid paid")
        //            let data = facility.preparePaidServicesRequestBody()
        //
        //            createFacilityUseCase.updateFacility(with: facility.id, for: .stepFour, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(let error):
        //                    print("error \(error)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = true
        //                    }
        //
        //                case .success(let success):
        //                    print("success \(success)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = false
        //                        self?.willShowRulesScreen = true
        //                    }
        //                }
        //            }
        //
        //        } else {
        //            print("Invalid paid amenity")
        //        }
        //        self.objectWillChange.send()
    }
    
    
    //MARK: - Step-5
    
    func updateFacilityRules() {
        
        willShowLocationScreen = true
        //        willShowLocationScreen.toggle()
        //        let data = facility.prepareRulesRequestBody()
        //
        //        createFacilityUseCase.updateFacility(with: facility.id, for: .stepFive, with: data) { [weak self] result in
        //            switch result {
        //            case .failure(let error):
        //                print("error \(error)")
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = true
        //                }
        //
        //            case .success(let success):
        //                print("success \(success)")
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = false
        //                    self?.willShowLocationScreen = true
        //                }
        //            }
        //        }
    }
    
    
    //MARK: - Step-6.1
    // Note: This is step-6 because photos selection has been moved last step.
    func validateAddress() {
        facilityLocationViewModel.onContinueTapped()
    }
    
    
    //MARK: - Step-6.2
    func updateFacilityLocation(with coordinates: CLLocationCoordinate2D) {
        willShowCheckInScreen = true
        //        facility.location.latitude = coordinates.latitude
        //        facility.location.longitude = coordinates.longitude
        //
        //        let data = facility.prepareLocationRequestBody()
        //        print("loc --> \(data)")
        //        createFacilityUseCase.updateFacility(with: facility.id, for: .stepSix, with: data) { [weak self] result in
        //            switch result {
        //            case .failure(let error):
        //                print("error \(error)")
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = true
        //                }
        //
        //            case .success(let success):
        //                print("success \(success)")
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = false
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
        //            createFacilityUseCase.updateFacility(with: facility.id, for: .stepSeven, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(let error):
        //                    print("error \(error)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = true
        //                    }
        //
        //                case .success(let success):
        //                    print("success \(success)")
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = false
        //                        self?.willShowPriceSetupScreen = true
        //                    }
        //                }
        //            }
        //        }
    }
    
    
    //MARK: - Step-8
    func validateFaciltyPrice(){
        willShowDescriptionScreen = true
        //        if facility.hasValidPrice() {
        //
        //            let data = facility.preparePriceRequestBody()
        //
        //            createFacilityUseCase.updateFacility(with: facility.id, for: .stepEight, with: data) { [weak self] result in
        //                switch result {
        //                case .failure(_):
        //
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = true
        //                    }
        //
        //                case .success(_):
        //
        //                    DispatchQueue.main.async {
        //                        self?.shallRetry = false
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
        //        createFacilityUseCase.updateFacility(with: facility.id, for: .stepNine, with: data) { [weak self] result in
        //            switch result {
        //            case .failure(_):
        //
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = true
        //                }
        //
        //            case .success(_):
        //
        //                DispatchQueue.main.async {
        //                    self?.shallRetry = false
        //                    self?.willShowPhotosScreen = true
        //                }
        //            }
        //        }
    }
    
    
    //MARK: - Step-10
    func getChecklist() {
        createFacilityUseCase.getChecklist(for: facility.id) { [weak self] result in
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
        createFacilityUseCase.publishFacility(with: facility.id)  { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.showToast = true
                    self.toastStyle = .success
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    UIApplicationHelper.popToRootView()
                }
            case .failure(_):
                
                DispatchQueue.main.async {
                    self.showToast = true
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
        facilityRoomsViewModel.increaseCount(of: .livingRoom)
    }
    
    func removeRoom() {
        facilityRoomsViewModel.decreaseCount(of: .livingRoom)
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

enum FacilityCreationProcess: String {
    case new = "new"
    case unpublished = "unpublished"
}
