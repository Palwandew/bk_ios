//
//  AvailableFacilitiesListViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import Foundation

class AvailableFacilitiesListViewModel: ObservableObject {
    
    @Published var facilities: [AvailableFacilityViewModel] = []
    @Published var state: ScreenState = .success
    
    init(){
        self.getAvailableFacilities()
    }
    
    
    private func getAvailableFacilities() {
        
        let repository = FacilityRepositoryImpl()
        
        repository.getFacilities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bookings):
                    self?.state = .success
                    self?.facilities = bookings.map(AvailableFacilityViewModel.init)
                    
                case .failure(_):
                    print("error occured")
                    self?.state = .failed
                }
            }
        }
    }
}

class AvailableFacilityViewModel: Identifiable {
    
    let id: Int
    let booking: Booking
    
    
    init(booking: Booking) {
        self.id = booking.bookingID
        self.booking = booking
        
        
    }
    
    var imgURL: String {
        return self.booking.facility.images.first?.photo ?? ""
    }
    
    var bookedDates: String {
        return stringDate(date: self.booking.bookingDates.startDate, endDate: self.booking.bookingDates.endDate)
    }
    
    var description: String {
        return self.booking.facility.facilityDescription
    }
    
    var address: String {
        return self.booking.facility.address
    }
    
    private func stringDate(date: String, endDate: String) -> String {
        
        let startDate = getDateFrom(date)
        let endDate = getDateFrom(endDate)
        
        
        if getYear(date: startDate) == getYear(date: endDate) {
            let startDate = getDateString(date: startDate)
            let shortenedDate = startDate.split(separator: ",")
            
            return shortenedDate[0] + " - " + getDateString(date: endDate)
        } else {
            return getDateString(date: startDate) + " - " + getDateString(date: endDate)
        }
        
        
    }
    
    private func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    private func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    private func getDateFrom(_ date: String) -> Date {
        let ha = date.split(separator: "-")
        
        let year = Int(ha[0])
        let month = Int(ha[1])
        let day = Int(ha[2])
        
        
        let morningOfChristmasComponents = DateComponents(calendar: Calendar.current,
                                                          year: year,
                                                          month: month,
                                                          day: day,
                                                          hour: 7,
                                                          minute: 0,
                                                          second: 0)
        
        let morningOfChristmas = morningOfChristmasComponents.date!
        
        return morningOfChristmas
    }
    
}

