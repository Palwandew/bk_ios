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
    @Published var state: ScreenState = .loading
    @Published var facilities: [OfferFacilityViewModel] = []
    var selectedFacility = OfferFacilityViewModel(facility: OfferFacility(englishName: "", address: "", price: 0, id: "1"))
    @Published var offer: Offer = Offer(facilityID: "1", originalPrice: 0, discount: "", type: "sar", startDate: Date(), endDate: Date())
    
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
    
    var price: String {
        return String(self.facility.price ?? 0)
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
    
    var price: String {
        return String(self.offerItem.price)
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
    
    
}
