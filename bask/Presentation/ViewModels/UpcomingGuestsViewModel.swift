//
//  UpcomingGuestsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 17/09/2022.
//

import Foundation

class UpcomingGuestsViewModel: ObservableObject {
    
    private let repository: GuestsDomainRepoProtocol
    
    @Published var upcomingGuests: [UpComingGuestViewModel] = []
    @Published var state: ScreenState = .loading
    
    init(repository: GuestsDomainRepoProtocol){
        self.repository = repository
        getUpcomingGuests()
    }
    
    func getUpcomingGuests() {
        
        let endPoint = Endpoints.GET_UPCOMING_GUESTS
        
        repository.getAllGuests(endPoint, response: UpcomingGuestsResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                    self?.state = .failed
                
                case .success(let response):
                    self?.state = .success
                    self?.upcomingGuests = response.data.upcomingGuests.map(UpComingGuestViewModel.init)
                }
            }
        }
    }
}

class UpComingGuestViewModel: Identifiable {
    
    let id: Int
    let guest: UpcomingGuest
    
    init(guest: UpcomingGuest){
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
