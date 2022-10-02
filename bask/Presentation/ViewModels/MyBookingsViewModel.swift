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

    @Published var facilityToConfirmBooking: UpcomingBookingItemViewModel? = nil
    @Published var upComingBookings: [UpcomingBookingItemViewModel] = []
    @Published var presentBookings: [PresentBookingItemViewModel] = []
    @Published var pastBookings: [PastBookingItemViewModel] = []
    

    
    @Published var toast: ToastViewModel = ToastViewModel()
    
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
    
    func acceptBooking(){
        guard let facilityToConfirmBooking = facilityToConfirmBooking else {
            return
        }
        screenState = .loading
        repository.acceptBooking(with: facilityToConfirmBooking.bookingID) { [weak self] result in
            DispatchQueue.main.async {
                self?.screenState = .success
                switch result {
                case .failure(_):
                    print("Error occuree")
                    self?.toast.prepare(for: .failure, with: "Error occured while accepting the booking. Please try again.")
                    
                case .success(_):
                    self?.toast.prepare(for: .success, with: "Booking has been accepted successfully.")
                }
                self?.toast.show()
                self?.objectWillChange.send()
            }
        }
    }
    
    func declineBooking(){
        guard let facilityToConfirmBooking = facilityToConfirmBooking else {
            return
        }
        screenState = .loading
        repository.declineBooking(with: facilityToConfirmBooking.bookingID) { [weak self] result in
            DispatchQueue.main.async {
                self?.screenState = .success
                switch result {
                case .failure(_):
                    print("Error occuree")
                    self?.toast.prepare(for: .failure, with: "Error occured while decling the booking. Please try again.")
                    
                case .success(_):
                    self?.toast.prepare(for: .success, with: "Booking has been declined successfully.")
                }
                self?.toast.show()
                self?.objectWillChange.send()
            }
        }
        
    }
    
    func getPresentBookings() {
        screenState = .loading
        repository.getPresentBookings() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    print("Error occuree")
                    
                    self?.screenState = .failed
                case .success(let presentBookings):
                    
                    
                    self?.presentBookings = presentBookings.map(PresentBookingItemViewModel.init)
                    self?.screenState = .success
                }
            }
        }
    }
    
    func getPastBookings() {
        screenState = .loading
        repository.getPastBookings() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    print("Error occuree")
                    
                    self?.screenState = .failed
                case .success(let pastBookings):
                    
                    
                    self?.pastBookings = pastBookings.map(PastBookingItemViewModel.init)
                    self?.screenState = .success
                }
            }
        }
    }
    
    private func getUpcomingBookings() {
        
        repository.getUpcomingBookings { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    print("Error occuree")
                    
                    self?.screenState = .failed
                case .success(let upComingBookings):
                    
                    let filteredArray = upComingBookings.filter { upcomingBooking in
                        upcomingBooking.bookingstatus.statusName != "rejected"
                    }
                    self?.upComingBookings = filteredArray.map(UpcomingBookingItemViewModel.init)
                    self?.screenState = .success
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


class PresentBookingItemViewModel: Identifiable {
    let id: Int
    private let facility: PresentBooking
    
    init(facility: PresentBooking){
        self.facility = facility
        self.id = facility.id
    }
    
    var price: Int {
        self.facility.price
    }
    
    var name: String {
        self.facility.englishName
    }
    
    var bookedDates: String {
        let startDate = Calendar.current.generateDate(from: self.facility.bookingDates.startDate)
        guard let date = startDate else { return ""}
        let startDateString = DateFormatter.startDate.string(from: date)
        
        let endDate = Calendar.current.generateDate(from: self.facility.bookingDates.endDate)
        guard let date = endDate else { return ""}
        let endDateString = DateFormatter.endDate.string(from: date)
        
        return startDateString + " - " + endDateString
    }
    
    var imageURL: String {
        self.facility.facility.images.first?.photo ?? "imageDummyURL"
    }
    
}


class PastBookingItemViewModel: Identifiable {
    let id: Int
    private let facility: PastBooking
    
    init(facility: PastBooking){
        self.facility = facility
        self.id = facility.id
    }
    
    var price: Int {
        self.facility.price
    }
    
    var name: String {
        self.facility.englishName
    }
    
    var bookedDates: String {
        let startDate = Calendar.current.generateDate(from: self.facility.bookingDates.startDate)
        guard let date = startDate else { return ""}
        let startDateString = DateFormatter.startDate.string(from: date)
        
        let endDate = Calendar.current.generateDate(from: self.facility.bookingDates.endDate)
        guard let date = endDate else { return ""}
        let endDateString = DateFormatter.endDate.string(from: date)
        
        return startDateString + " - " + endDateString
    }
    
    var imageURL: String {
        self.facility.facility.images.first?.photo ?? "imageDummyURL"
    }
    
    var isCancelled: Bool {
        return self.facility.bookingstatus.statusName == "rejected" 
    }
}


class UpcomingBookingItemViewModel: Identifiable {
    
    let id: Int
    private let facility: UpcomingBooking
    
    init(facility: UpcomingBooking){
        self.id = facility.id
        self.facility = facility
    }
    
    var bookingID: String {
        String(self.facility.id)
    }
    
    var price: Int {
        self.facility.price
    }
    
    var name: String {
        self.facility.englishName
    }
    
    
    var bookedDates: String {
        let startDate = Calendar.current.generateDate(from: self.facility.bookingDates.startDate)
        guard let date = startDate else { return ""}
        let startDateString = DateFormatter.startDate.string(from: date)
        
        let endDate = Calendar.current.generateDate(from: self.facility.bookingDates.endDate)
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
        let startDate = Calendar.current.generateDate(from: self.facility.bookingDates.startDate)
        guard let startDate = startDate else { return nil}
        
        let endDate = Calendar.current.generateDate(from: self.facility.bookingDates.endDate)
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

