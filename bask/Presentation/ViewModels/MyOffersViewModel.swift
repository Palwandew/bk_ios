//
//  MyOffersViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

class MyOffersViewModel: ObservableObject {
    
    private let useCase: OffersUsecase
    @Published var offers: [OfferItemViewModel] = []
    @Published var state: ScreenState = .success
    @Published var facilities: [OfferFacilityViewModel] = []
    var selectedFacility = OfferFacilityViewModel(facility: OfferFacility(englishName: "", address: "", price: 0, id: "1"))
    @Published var offer: Offer = Offer(facilityID: "1", originalPrice: 0, discount: "", type: "sar", startDate: Date(), endDate: Date())
    
    // Properties for offer item details screen
    private var isSameOfferItem: Bool = false
    private var offerItem: OfferItemViewModel? = nil
    @Published var offerItemDetail: OfferItemDetailsViewModel? = nil
    
    
    init(useCase: OffersUsecase){
        print("Init MyOffersViewModel()")
        self.useCase = useCase
        getOffers()
    }
    
    private func getOffers() {
        useCase.getAllOffers { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let items):
                    self?.offers = items.map(OfferItemViewModel.init)
                    self?.state = .success
                    
                case .failure(let error):
                    print("Error occured \(error)")
                    self?.state = .failed
                }
            }
        }
    }
    
    func prepareDetailsOf(_ itemSelectedByUser: OfferItemViewModel){
        checkForNewItem(itemSelectedByUser)
        
    }
    
    
    /// This will check if the user has tapped on the same item or a new one.
    /// - Parameter newOfferItem: offer item selected by the user.
    private func checkForNewItem(_ newOfferItem: OfferItemViewModel){
        if let offerItem = offerItem  {
            if newOfferItem.offerID == offerItem.offerID {
                isSameOfferItem = true
            } else {
                isSameOfferItem = false
                self.offerItem = newOfferItem
                self.state = .loading
            }
        } else {
            self.state = .loading
            offerItem = newOfferItem
        }
    }
    
    func updateTheScreenState(){
        state = .loading
        getOfferItemDetails()
    }
    
    func getOfferItemDetails(){
        //state = .loading
        guard let offerItem = offerItem else {
            return
        }

        if !isSameOfferItem{
            print("new item")
            useCase.getOfferItemDetails(with: offerItem.offerID, and: offerItem.facilityID) { [weak self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let itemDetails):
                        print("Data >>> \(itemDetails)")
                        self?.offerItemDetail = OfferItemDetailsViewModel(offerItem: itemDetails)
                        self?.state = .success
                        
                    case .failure(let error):
                        print("error occ \(error)")
                        self?.state = .failed
                    }
                }
            }
        } else { print("Same item")}
    }
    
    func getFacilities() {
        
        useCase.getFacilitiesForOffer { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let facilities):
                    self?.state = .success
                    self?.facilities = facilities.map(OfferFacilityViewModel.init)
                case .failure(let error):
                    print("Error occured \(error)")
                    self?.state = .failed
                }
            }
        }
    }
}


class OfferFacilityViewModel: Identifiable {
    
    let id: String 
    private let facility: OfferFacility
    
    init(facility: OfferFacility){
        self.id = facility.id
        self.facility = facility
    }
    
    var facilityID: String {
        return self.facility.id
    }
    
    var price: Int {
        return self.facility.price ?? 0
    }
    
    var name: String {
        return facility.englishName
    }
    
    var address: String {
        return facility.address ?? ""
    }
}

class OfferItemViewModel: Identifiable {
    
    let id: Int
    private let offerItem: OfferItem
    
    init(item: OfferItem){
        self.id = item.id
        self.offerItem = item
    }
    
    var photoURL: String {
        return self.offerItem.photo
    }
    
    var price: Int {
        return self.offerItem.price
    }
    
    var discount: String {
        return String(self.offerItem.discount)
    }
    
    var discountType: String{
        return self.discountType
    }
        
    var name: String {
        return self.offerItem.englishName
    }
    
    var address: String {
        return self.offerItem.address
    }
    
    var facilityID: String {
        return self.offerItem.facilityID
    }
    
    var offerID: String {
        return String(self.offerItem.id)
    }
    
    
}


struct OfferItemDetailsViewModel {
    private let localizationHelper = LocalizationHelper()
    private let offerItem: OfferItemDetails
    init(offerItem: OfferItemDetails){
        self.offerItem = offerItem
    }
    
    var images: [FacilityImage] {
        return self.offerItem.images
    }
    
    var price: Int {
        self.offerItem.price

    }
    
    var rating: String {
        return "4.3"
    }
    
    var name: String {
        self.offerItem.englishName
    }
    
    var discountAmount: Int {
        
        return self.offerItem.offer.first?.discount ?? 0
    }
    
    var livingSpace: String {
        return localizationHelper.getLocalizedNumber(self.offerItem.length * self.offerItem.width) 
    }
    
    var livingRooms: String {
        return localizationHelper.getLocalizedNumber(from: self.offerItem.noOfLivingrooms)
    }
    
    var capacity: String {
        return localizationHelper.getLocalizedNumber(self.offerItem.capacity)
    }
    
    var owner: String {
        self.offerItem.owner.fullName
    }
    
    var arrivalTime: String {
        return localizationHelper.getLocalizedTime(from: self.offerItem.checkInAfter)
    }
    
    var address: String {
        self.offerItem.address
    }
}
