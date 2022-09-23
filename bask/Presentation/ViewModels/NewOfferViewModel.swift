//
//  NewOfferViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/09/2022.
//

import Foundation

class NewOfferViewModel: ObservableObject {
    
    
    private let useCase: OffersUsecase
    
    @Published var offer = Offer(facilityID: "fakeId", originalPrice: 0, discount: "", type: "sar", startDate: nil, endDate: nil)
    @Published var validPrice: Bool = true
    @Published var didAddPrice: Bool = false
    @Published var amountEntryErrorLocalizationKey: String = "empty offer price"
    @Published var toast: ToastViewModel = ToastViewModel()
    
    private var facilityOriginalPrice: Int = 0
    
    init(useCase: OffersUsecase){
        self.useCase = useCase
    }
    
    func onContinueTapped() {
        if didAddPrice{
            if offer.hadValidOfferDates() {
                       createNewOffer()
            }
        } else {
            validateDiscountPrice()
        }

    }
    
    func prepareModel(for facility: OfferFacilityViewModel){
        facilityOriginalPrice = facility.price
        
        let offer = Offer(facilityID: facility.facilityID, originalPrice: facilityOriginalPrice, discount: "", type: "sar", startDate: nil, endDate: nil)
        
        self.offer = offer
        
    }
    
    func updateDates(_ startDate: Date?, _ endDate: Date?){
        if let startDate = startDate {
            offer.startDate = startDate
        }
        if let endDate = endDate {
            offer.endDate = endDate
        }
    }
    
    private func validateDiscountPrice() {
        if offer.hasDiscountAmountAdded() && offer.newPrice > 0 {
            validPrice = true
            didAddPrice = true
        } else {
            if offer.newPrice < 0 {
                amountEntryErrorLocalizationKey = "invalid discount price"
            }
            validPrice = false
            didAddPrice = false
        }
    }
    
    private func createNewOffer(){
        useCase.createNewOffer(with: offer) { [weak self] result in
     
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print(message)
                    self?.toast.prepare(for: ToastStyle.success, with: "Offer created successfully.")
                    self?.toast.show()
                    
                case .failure(let error):
                    print("Error occured \(error)")
                    self?.toast.prepare(for: ToastStyle.failure, with: "Error occured. Please try again.")
                    self?.toast.show()
                }
                self?.objectWillChange.send()
            }
        }
    }
}
