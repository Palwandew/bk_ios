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
        
        facilityRepo.getFacility(endpoint) { Result<Decodable & Encodable, Error> in
            <#code#>
        }
    }
    
}

struct LocalDate {
    let day: String
    let month: String
    let year: String
}
