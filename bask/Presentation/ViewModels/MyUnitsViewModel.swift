//
//  MyUnitsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import Foundation

class MyUnitsViewModel: ObservableObject {
    @Published var isLoadingAlertPresented: Bool = false
    @Published var screenState: ScreenState = .loading
    
    //MARK: - Booked Facilities
    @Published var bookedFacilities: [Int] = [32]
    
    init(){
        print("MyUnitsViewModel -> init()")
    }
    
    func updateState() {
        print("updating state")
        if screenState == .success {
            //changeState(state: .loading)
            print("sccuss state")
        }
        
        if screenState == .loading {
            print("loading state")
            changeState(state: .success)
        }
//        else {
//        changeState(state: .success)
//        }
        //changeState(state: .failed)
    }
    
    private func changeState(state: ScreenState) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.screenState = state
        }
    }
    
    deinit{
        print("MyUnitsViewModel -> deInit()")
    }
}

class BookedFacilityViewModel: Identifiable {
    
    let id: Int
    let booking: Booking
    
    
    init(booking: Booking) {
        self.id = booking.bookingID
        self.booking = booking
        
        
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
    
    func stringDate(date: String, endDate: String) -> String {
        
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
    
    func getDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func getYear(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    
    func getDateFrom(_ date: String) -> Date {
        let ha = date.split(separator: "-")
    
        let year = Int(ha[0])
        let month = Int(ha[1])
        let day = Int(ha[2])
        print("Year \(ha[0])")
        print("Month \(ha[1])")
        print("Day \(ha[2])")
        

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


class BookedFacilitiesListViewModel: ObservableObject {
    
    @Published var facilities: [BookedFacilityViewModel] = []
    @Published var state: ScreenState = .loading
    
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
