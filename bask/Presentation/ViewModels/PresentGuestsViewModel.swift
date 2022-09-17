//
//  PresentGuestsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

class PresentGuestsViewModel: ObservableObject {
    
    private let repository: GuestsDomainRepoProtocol
    
    @Published var presentGuests: [PresentGuestViewModel] = []
    @Published var state: ScreenState = .loading
    
    init(repository: GuestsDomainRepoProtocol){
        self.repository = repository
        getPresentGuests()
    }
    
    private func getPresentGuests() {
        
        let endPoint = Endpoints.GET_PRESENT_GUESTS
        
        repository.getAllGuests(endPoint, response: PresentGuestsResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                    self?.state = .failed
                
                case .success(let response):
                    self?.state = .success
                    self?.presentGuests = response.data.presentGuests.map(PresentGuestViewModel.init)
                }
            }
        }
    }
}

class PresentGuestViewModel: Identifiable {
    
    let id: Int
    let guest: PresentGuest
    
    init(guest: PresentGuest){
        self.id = guest.id
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
