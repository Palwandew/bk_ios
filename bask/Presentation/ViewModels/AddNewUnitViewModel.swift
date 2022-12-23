//
//  AddNewUnitViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import Foundation
import CoreLocation


class FacilityNameViewModel: ObservableObject {
    
    @Published var englishName: String = ""
    @Published var arabicName: String = ""
    @Published var englishNameError: Bool = false
    @Published var arabicNameError: Bool = false
    @Published var shallNavigate: Bool = false
    var isFacilityNameValid: Bool {
        return (!englishNameError && !arabicNameError)
    }
    
    func validFacilityName() -> Bool {
        if englishName.isEmpty || englishName.count < 3 {
            self.englishNameError = true
        }
        
        if arabicName.isEmpty || arabicName.count < 3 {
            self.arabicNameError = true
        }
        
        return isFacilityNameValid
    }
   
}

class FacilityRoomsViewModel: ObservableObject {
    @Published var facilityWidth: String = ""
    @Published var facilityLength: String = ""
    @Published var livingRoomsCount: Int = 0
    @Published var kitchensCount: Int = 0
    @Published var bathroomsCount: Int = 0
    @Published var showersCount: Int = 0
    @Published var personCapacity: Int = 0
    @Published var validWidth: Bool = true
    @Published var validLength: Bool = true
    var isRoomsDataValid: Bool {
        return (validLength && validWidth && (livingRoomsCount > 0 && personCapacity > 0))
    }
    @Published var shallNavigate: Bool = false
    @Published var toast: ToastViewModel = ToastViewModel()
    
    
    func validateRoomsData(){
        UIApplicationHelper.dimissKeyboard()
        validateFacilitySize()
        validateLivingRoomsAndCapacityCount()
        
        print("Valid value ---> \(isRoomsDataValid)")
    }
    
    private func validateFacilitySize() {
        if facilityWidth.isEmpty {
            self.validWidth = false
        }
        if facilityLength.isEmpty {
            self.validLength = false
        }
    }
    
    private func validateLivingRoomsAndCapacityCount() {
        if livingRoomsCount < 1 || personCapacity < 1{
            showErrorToast(with: "Facility must contain a living room and accomodate at least one person to continue")
            self.objectWillChange.send()
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
    @Published var wifi: Bool = false
    @Published var parking: Bool = false
    @Published var indoorPool: Bool = false
    @Published var outdoorPool: Bool = false
    @Published var outdoorSitting: Bool = false
    @Published var bbq: Bool = false
    @Published var gym: Bool = false
    @Published var gamesRoom: Bool = false
    @Published var garden: Bool = false
    @Published var playingField: Bool = false
}

class FacilityRulesViewModel: ObservableObject{
    @Published var petsAllowed: Bool = true
    @Published var allPetsAllowed: Bool = false
    @Published var cats: Bool = true
    @Published var dogs: Bool = false
    @Published var rodents: Bool = false
    @Published var reptile: Bool = false
    @Published var bigAnimals: Bool = false
    @Published var allowedToSmoke: Bool = true
    @Published var additonalRules: Bool = false
    @Published var additionalRulesDescription: String = ""
}

class FacilityLocationViewModel: ObservableObject{
    
    
    var country: String = "Saudi Arabia"
    @Published var city: String = ""
    @Published var validCity: Bool = true
    @Published var street: String = ""
    @Published var validStreet: Bool = true
    @Published var longitude: Double = 45.11031652737802
    @Published var latitude: Double = 24.19970898091148
    var isStreetAddressValid: Bool {
        return validCity && validStreet
    }
    
    
    func validateFacilityAddress() {
        updateValidationStatus(of: city, with: &validCity)
        updateValidationStatus(of: street, with: &validStreet)
    }
    
    private func updateValidationStatus(of string: String, with validityIndicator: inout Bool) {
        if string.isEmpty || string.count < 3 {
            validityIndicator = false
        } else {
            validityIndicator = true
        }
    }
    
    func updateMapPin(with mapCenter : CLLocationCoordinate2D) {
        self.latitude = mapCenter.latitude
        self.longitude = mapCenter.longitude
    }
}

class CheckInCheckOutViewModel: ObservableObject {
    @Published var checkInTime: String = "12:00 PM"
    @Published var checkOutTime: String = "12:00 PM"
    
}

class FacilityPriceViewModel: ObservableObject {
    @Published var pricePerNight: String = ""
    @Published var deposit: String = ""
    @Published var validPerNightPrice: Bool = true
    @Published var validDepositPrice: Bool = true
    
    var isFacilityPriceValid: Bool {
        return validDepositPrice && validPerNightPrice
    }
    
    func validateFacilityPrice(){
        validPerNightPrice = validatePrice(pricePerNight)
        validDepositPrice = validatePrice(deposit)
    }
    
    private func validatePrice(_ price: String) -> Bool {
        return !price.isEmpty && price != "0"
        
    }
}

class FacilityDescriptionViewModel: ObservableObject {
    @Published var description: String = ""
}

class PublishFacilityViewModel: ObservableObject {
    
    private let publishFacilityUseCase: PublishFacilityUseCase
    private let uploadPhotosUseCase: PhotosUsecase
    @Published var title: String = "Publish your ad"
    @Published var progress: Double = 0.0
    @Published var status: UploadingStatusIndicator = .initial
    @Published var dataStatus: UploadingStatusIndicator = .initial
    @Published var photosStatus: UploadingStatusIndicator = .initial
    var showPhotosIndicator: Bool {
        return !photosToUpload.isEmpty
    }
    private var facility: Facility? = nil
    private var photosToUpload: [URL] = []
    private var facilityID: String? = nil
    
    init(publishFacilityUseCase: PublishFacilityUseCase, uploadPhotosUseCase: PhotosUsecase){
        self.publishFacilityUseCase = publishFacilityUseCase
        self.uploadPhotosUseCase = uploadPhotosUseCase
    }
    
    func perpareDataToPublish(_ facility: Facility, with photos: [URL]){
        self.facility = facility
        self.photosToUpload = photos
        
    }
    
    func updateTitle(_ newTitle: String) {
        title = newTitle
    }
    
    func updateAllUploadingStatusIndicators(with newStatus: UploadingStatusIndicator){
        status = newStatus
        dataStatus = newStatus
        photosStatus = newStatus
    }
    
    func retryOperation(){
        print("retry")
    }
    
    func publishFacility(){
        guard let facility = facility else { return }
        self.status = .uploading
        
        publishFacilityUseCase.publishFacility(facility) { [weak self] result in
            self?.handleFacilityDataUploadingResult(result)
        }

    }
    
    func saveUnpublished(){
        
        guard let facility = facility else { return }
        self.status = .uploading
        publishFacilityUseCase.saveUnpublished(facility) { [weak self] result in
            
            self?.handleFacilityDataUploadingResult(result)
        }
    }
    
    private func handleFacilityDataUploadingResult(_ result: Result<String, Error>){
        DispatchQueue.main.async {
            switch result {
            case .success(let facilityID):
                
                self.dataStatus = .success
                self.facilityID = facilityID
                if self.showPhotosIndicator {
                    self.initiatePhotosUploading()
                }
                self.objectWillChange.send()
                
            case .failure(_):
                self.updateAllUploadingStatusIndicators(with: .error)
                
            }
        }
    }
    
    private func initiatePhotosUploading(){

        guard let facilityID = facilityID else {
            return
        }
        uploadPhotos(facilityID)
        
    }
    
    
    private func uploadPhotos(_ facilityID: String){
        

        let firstURL = photosToUpload.removeFirst()
       
    
        self.uploadPhotosUseCase.uploadPhoto(of: facilityID, from: firstURL) { progress in
            
            DispatchQueue.main.async {
                self.progress = progress
                
            }
        } completion: { [weak self] result in
            switch result{
            case .failure(_):
                
                DispatchQueue.main.async {
                    self?.status = .error
                    self?.photosStatus = .error
                }
                
            case .success(_):
                if !(self?.photosToUpload.isEmpty)! {
                    self?.uploadPhotos(facilityID)
                } else {
                    DispatchQueue.main.async {
                        // Navigate
                        self?.status = .success
                        self?.photosStatus = .success
                    }
                }
            }
        }
    }
}


//MARK: - AddNewUnitViewModel
class AddNewUnitViewModel: ObservableObject {
    
    private let ownerId = "7ae267e8-65cc-4c6d-948a-5518a8bfeb36"
    //MARK: - Usecase
    private let publishFacilityUseCase: PublishFacilityUseCase
    // New Implementation
    @Published var creationSteps: [FacilityCreationState] = [.name]
    @Published var currentStep: FacilityCreationState = .name
    @Published var currentProgress: Float = 1/10
    @Published var title: String = "Name of facility"
    @Published var showPublishScreen: Bool = false
    
    @Published var facilityNameViewModel: FacilityNameViewModel = FacilityNameViewModel()
    @Published var facilityRoomsViewModel: FacilityRoomsViewModel = FacilityRoomsViewModel()
    @Published var facilityAmenitiesViewModel: FacilityAmenitiesViewModel = FacilityAmenitiesViewModel()
    @Published var facilityRulesViewModel: FacilityRulesViewModel = FacilityRulesViewModel()
    @Published var facilityLocationViewModel: FacilityLocationViewModel = FacilityLocationViewModel()
    @Published var checkInCheckOutViewModel: CheckInCheckOutViewModel = CheckInCheckOutViewModel()
    @Published var facilityPriceViewModel: FacilityPriceViewModel = FacilityPriceViewModel()
    
    
    @Published var facilityDescriptionViewModel: FacilityDescriptionViewModel = FacilityDescriptionViewModel()
    
    @Published var publishFacilityViewModel: PublishFacilityViewModel = PublishFacilityViewModel(publishFacilityUseCase: PublishFacilityUseCase(repository: FacilityRepositoryImpl()), uploadPhotosUseCase: PhotosUsecase(repo: PhotosRepositoryImpl(uploadManager: PhotosUploadManager())))
    
    @Published var photosViewModel: PhotosViewModel = PhotosViewModel()
    // Retry button indicator
    @Published var shallRetry: Bool = false
    
    init(useCase: PublishFacilityUseCase){
        print("Init create new facility view model")
        publishFacilityUseCase = useCase
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
        case .pictures:
            updateTitle(with: "Add Photos")
        }
    }
    
    private func updateTitle(with newTitle: String){
        title = newTitle
    }
    
    
    //MARK: - New Implementation Helper
    
    
    func onBackButtonTapped(){
        performBackAction()
    }
    
    func onContinueButtonTapped(){
        if validateUserInput(for: currentStep) {
            if currentStep == .pictures {
                
                guard let facility = buildFacility(status: "unpublished") else {
                    return
                }
                publishFacilityViewModel.perpareDataToPublish(facility, with: photosViewModel.urls)
                showPublishScreen = true
            } else {
                pushNextState()
            }
        }
        
    }
    private func pushNextState(){
        if !creationSteps.contains(currentStep.next()) {
            currentStep = currentStep.next()
            creationSteps.append(currentStep)
            updateProgressBar()
            onContinueTapped(nextStep: currentStep)
        }
    }
    
    private func performBackAction() {
        guard creationSteps.count > 1 else { return }
        creationSteps.removeAll(where: {$0 == currentStep})
        currentStep = currentStep.previous()
        updateProgressBar(increase: false)
        onBackTapped(previousStep: currentStep)
    }
    
    private func updateProgressBar(increase: Bool = true){
        
        let steps: Float = 1/10
        
        if increase{
            currentProgress += steps
        } else {
            currentProgress -= steps
        }
    }
    
    private func validateUserInput(for step: FacilityCreationState) -> Bool{
        switch step {
        case .name:
            return facilityNameViewModel.validFacilityName()
        case .rooms:
            facilityRoomsViewModel.validateRoomsData()
            return facilityRoomsViewModel.isRoomsDataValid
        case .amenities:
            return true
        case .rules:
            return true
        case .address:
            facilityLocationViewModel.validateFacilityAddress()
            return facilityLocationViewModel.isStreetAddressValid
        case .map:
            return true
        case .checkInTime:
            return true
        case .price:
            facilityPriceViewModel.validateFacilityPrice()
            return facilityPriceViewModel.isFacilityPriceValid
        case .description:
            return true
        case .pictures:
            return true
        }
    }
    
    
    
    
    private func buildFacility(status: String) -> Facility? {
        let facility = FacilityBuilder()
            .setOwnerID("62d7326b-e6e9-4614-abe7-afd9a28f77f5")
            .setStatus(status)
            .setName(from: facilityNameViewModel)
            .setRoomsData(from: facilityRoomsViewModel)?
            .setAmenities(from: facilityAmenitiesViewModel)
            .setRules(from: facilityRulesViewModel)
            .setAddress(from: facilityLocationViewModel)
            .setPrice(from: facilityPriceViewModel)?
            .setDescription(from: facilityDescriptionViewModel)
            .setCheckInTime(from: checkInCheckOutViewModel)
            .build()
        
        return facility
    }
    
}

