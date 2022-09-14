//
//  BookedFacilitiesListViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 12/09/2022.
//

import Foundation

class BookedFacilityViewModel: Identifiable {
    
    let id: Int
    let booking: Booking
    private let localizationHelper: LocalizationHelper
    
    
    init(booking: Booking) {
        self.localizationHelper = LocalizationHelper()
        self.id = booking.bookingID
        self.booking = booking
        
        
    }
    
    var imgURL: String {
        return self.booking.facility.images.first?.photo ?? ""
    }
    
    var bookedDates: String {
        let start = getDateFrom(self.booking.bookingDates.startDate)
        let end = getDateFrom(self.booking.bookingDates.endDate)
        
        let startDate = localizationHelper.getLocalizedDate(start)
        let endDate = localizationHelper.getLocalizedDate(end)
        
        return ("\(startDate.day) \(startDate.month) - \(endDate.day) \(endDate.month), \(endDate.year)")
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
    
    var startDate: Date {
        return getDateFrom(self.booking.bookingDates.startDate)
    }
    
    var endDate: Date {
        return getDateFrom(self.booking.bookingDates.endDate)
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
        print("Year \(ha[0])")
        print("Month \(ha[1])")
        print("Day \(ha[2])")
        
        
        let dateComponents = DateComponents(calendar: Calendar.current,
                                                          year: year,
                                                          month: month,
                                                          day: day,
                                                          hour: 7,
                                                          minute: 0,
                                                          second: 0)
        
        let date = dateComponents.date!
        
        return date
    }
    
}


class BookedFacilitiesListViewModel: ObservableObject {
    
    @Published var facilities: [BookedFacilityViewModel] = []
    @Published var state: ScreenState = .success
    
    init(){
        self.getBookedFacilities()
    }
    
    
    private func getBookedFacilities() {
        print("call the diff")
        let repository = FacilityRepositoryImpl()
        
        repository.getFacilities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let bookings):
                    self?.state = .success
                    self?.facilities = bookings.map(BookedFacilityViewModel.init)
                    
                case .failure(_):
                    print("error occured")
                    self?.state = .failed
                }
            }
        }
    }
}

