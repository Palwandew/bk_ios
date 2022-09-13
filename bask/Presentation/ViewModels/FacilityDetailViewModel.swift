//
//  FacilityDetailViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/09/2022.
//

import Foundation

class FacilityDetailViewModel: ObservableObject {
    
    private let facilityRepo: FacilityDomainReopProtocol
    private let localizationHelper = LocalizationHelper()
    
    @Published var startDate: LocalDate = LocalDate(day: "", month: "", year: "")
    @Published var endDate: LocalDate = LocalDate(day: "", month: "", year: "")
    @Published var pricePerNight: String? = nil
    @Published var rating: String? = nil
    
    @Published var facility: BookedFacilityDetailsViewModel? = nil
    
    init(repository: FacilityDomainReopProtocol){
        self.facilityRepo = repository
        print("Init----> facility details")
    }
    
    func updateBookingDatesFormat(_ startDate: Date, _ endDate: Date){
        
        self.startDate = localizationHelper.getLocalizedDate(startDate)
        self.endDate = localizationHelper.getLocalizedDate(endDate)
        
        self.pricePerNight = localizationHelper.getLocalizedNumber(300)
        self.rating = localizationHelper.getLocalizedNumber(4)
    }
    
    func getDetails(for facilityID: String, with bookingID: String){
        
        let queryItems = [URLQueryItem(name: "booking_id", value: bookingID), URLQueryItem(name: "facility_id", value: facilityID)]
        let endpoint = Endpoints.GET_BOOKED_ITEM(with: queryItems)
        
        facilityRepo.getFacility(endpoint, response: BookedFacilityItemResponse.self) { result in
            switch result {
                
            case .failure(let error):
                print("Error occured: \(error)")
                
            case .success(let response):
                
                DispatchQueue.main.async {
                    self.facility = BookedFacilityDetailsViewModel(facility: response.data.bookedItem)
                }
                print("heh")
                
            }
        }
        
    }
    
}

class BookedFacilityDetailsViewModel {
    let facility: BookedItem
    private let localizationHelper: LocalizationHelper
    init(facility: BookedItem){
        self.facility = facility
        self.localizationHelper = LocalizationHelper()
    }
    
    var price: String? {
        
        return localizationHelper.getLocalizedNumber(facility.price)
    }
    
    var rating: String? {
        return localizationHelper.getLocalizedNumber(4)
    }
    
    //Guest Name
    var guest: String? {
       return self.facility.booking.first?.customer.fullName
    }

    var guestRating: Double? {
        return self.facility.booking.first?.customer.rating
    }
    
    var arrivalTime: String? {
        return self.facility.checkInAfter
    }
    
    // cancellation policy is missing
    
    var livingSpace: String {
        return localizationHelper.getLocalizedNumber(self.facility.length * self.facility.width)
    }
    
    var livingRooms: String {
        return localizationHelper.getLocalizedNumber(from: self.facility.noOfLivingrooms)
    }
    
    var capacity: String {
        return localizationHelper.getLocalizedNumber(self.facility.capacity)
    }
    
}

struct LocalDate {
    let day: String
    let month: String
    let year: String
}
