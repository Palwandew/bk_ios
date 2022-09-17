//
//  RatingGuestsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

class RatingGuestsViewModel: ObservableObject {
    
    private let repository: GuestsDomainRepoProtocol
    
    @Published var unRatedGuests: [UnratedGuestViewModel] = []
    @Published var state: ScreenState = .loading
    
    init(repository: GuestsDomainRepoProtocol){
        self.repository = repository
        getGuests()
    }
    
    private func getGuests() {
        
        let endPoint = Endpoints.GET_GUESTS_RATINGS
        
        repository.getAllGuests(endPoint, response: RatingGuestsResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                    self?.state = .failed
                
                case .success(let response):
                    self?.state = .success
                    self?.unRatedGuests = response.data.unratedGuests.map(UnratedGuestViewModel.init)
                }
            }
        }
    }
    
    
}

class UnratedGuestViewModel: Identifiable {
    
    let id: Int
    let guest: UnratedGuestBookingData
    
    init(guest: UnratedGuestBookingData){
        self.id = guest.bookingID
        self.guest = guest
    }
    
    var facilityName: String {
        
        return self.guest.englishName
    }
    
    var facilityAddress: String {
        return self.guest.address
    }
    
    var name: String {
        return self.guest.customer.fullName
    }
    
    var chechInTime: String {
        return self.guest.checkInAfter
    }
    
    var checkOutTime: String {
        return self.guest.checkOutBefore
    }
    
    var startDate: String {
        return self.guest.bookingDates.startDate
    }
    
    var endDate: String {
        return self.guest.bookingDates.endDate
    }
    
    
}
