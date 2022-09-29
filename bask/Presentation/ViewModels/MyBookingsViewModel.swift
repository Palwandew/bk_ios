//
//  MyBookingsViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import Foundation

class MyBookingsViewModel: ObservableObject {
    @Published var isLoadingAlertPresented: Bool = false
    @Published var screenState: ScreenState = .loading
    
    @Published var facilities: [UpcomingBookingItemViewModel] = []
    
    @Published var facilityToConfirmBooking: UpcomingBookingItemViewModel? = nil 
    
    private let repository: BookingRepositoryProtocol
    
    
    
    init(_ repo: BookingRepositoryProtocol){
        print("MyBookingsViewModel -> init()")
        self.repository = repo
        
        getUpcomingBookings()
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
    }
    
    func prepareFacilityForConfirmationDialog(_ facility: UpcomingBookingItemViewModel) {
        self.facilityToConfirmBooking = facility
    }
    
    func declineBooking(){
        guard let facilityToConfirmBooking = facilityToConfirmBooking else {
            return
        }
        
    }
    
    private func getUpcomingBookings() {
        
        repository.getUpcomingBookings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    print("Error occuree")
                case .success(let upComingBookings):
                    self?.facilities = upComingBookings.map(UpcomingBookingItemViewModel.init)
                }
            }
        }
    }
    
    private func changeState(state: ScreenState) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.screenState = state
        }
    }
    
    deinit{
        print("MyBookingsViewModel -> deInit()")
    }
}


class UpcomingBookingItemViewModel: Identifiable {
    
    let id: Int
    private let facility: UpcomingBooking
    
    init(facility: UpcomingBooking){
        self.id = facility.id
        self.facility = facility
    }
    
    var price: Int {
        self.facility.price
    }
    
    var name: String {
        self.facility.englishName
    }
    
    
    var bookedDates: String {
        let startDate = generateDate(from: self.facility.bookingDates.startDate)
        guard let date = startDate else { return ""}
        let startDateString = DateFormatter.startDate.string(from: date)
        
        let endDate = generateDate(from: self.facility.bookingDates.endDate)
        guard let date = endDate else { return ""}
        let endDateString = DateFormatter.endDate.string(from: date)
        
        return startDateString + " - " + endDateString
    }
    
    var daysRemaining: Int {
        self.facility.remainingTime.days
    }
    
    var hoursRemaining: Int {
        self.facility.remainingTime.hours
    }
    
    var minutesRemainig: Int {
        self.facility.remainingTime.minutes
    }
    
    var status: BookingStatus {
        BookingStatus(rawValue: self.facility.bookingstatus.statusName) ?? .pending
    }
    
    var imageURL: String {
        self.facility.facility.images.first?.photo ?? "imageDummyURL"
    }
    
    
    private func generateDate(from date: String) -> Date? {
        let startDate = DateFormatter.check.date(from: date)
        guard let date = startDate else { return nil}
        
        return date
    }
    
    func getTotalDaysOfBooking() -> Int? {
        let startDate = generateDate(from: self.facility.bookingDates.startDate)
        guard let startDate = startDate else { return nil}
        
        let endDate = generateDate(from: self.facility.bookingDates.endDate)
        guard let endDate = endDate else { return nil}
        
        return Calendar.current.numberOfDaysBetween(startDate, and: endDate)
    }
}

enum ScreenState {
    case loading
    case success
    case failed
    case initial
}


enum BookingStatus: String {
    case accepted = "accepted"
    case pending = "awaiting"
    case declined = "rejected"
}

