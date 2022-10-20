//
//  CalendarScreenViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/10/2022.
//

import Foundation

/// View model for the `Calender Screen`
class CalendarScreenViewModel: ObservableObject {
    
    
    //MARK: - Repository
    private let repository: FacilityDomainReopProtocol
    
    
    //MARK: - Published properties
    @Published var facilities: [CalendarFacilityViewModel] = []
    @Published var selectedFacility: CalendarFacilityViewModel? = nil
    @Published var startDate: Date? = nil
    @Published var endDate: Date? = nil
    @Published var showAlertDialog: Bool = false
    @Published var priceChangeDialog: Bool = true 
    @Published var showSaveButton: Bool = false
    
    
    //MARK: - CalendarViewModel
    let calendarViewModel: CalendarViewModel = CalendarViewModel(repo: CalendarRepositoryImpl())
    
    
    
    //MARK: - init
    init(repo: FacilityDomainReopProtocol){
        self.repository = repo
        getAvailableFacilities()
    }
     
    /// This will get all the facilities of the user and get the calendar days data from back-end
    ///  of the first facility.
    func getAvailableFacilities(){
        self.repository.getAvailableFacilities { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let facilities):
                    self?.facilities = facilities.map(CalendarFacilityViewModel.init)
                    
                    
                    if let firstFacilityFromServer = self?.facilities.first {
                        
                        self?.updateSelectedFacility(with: firstFacilityFromServer)
                        self?.calendarViewModel.getCalendar(for: firstFacilityFromServer.facilityID, firstFacilityFromServer.defaultPrice)
                    }
                      
                case .failure(_):
                    self?.calendarViewModel.state = .failed
                }
            }
            
        }
    }
    
    /// This will check if the user has selected the facility.
    /// - Parameter facilityToCheck: Facility of the user.
    /// - Returns: `true` if the facility is selected, `false` otherwise.
    func isFacilitySelected(_ facilityToCheck: CalendarFacilityViewModel) -> Bool {
        
        return selectedFacility?.facilityID == facilityToCheck.facilityID
    }
    
     
    
    /// This will update the selected facility with a new one.
    /// - This method will change the currently selected facility to a provided one. This will
    ///  be invoked whenever the user selects a facility for the horizontal list in `Calendar Screen`
    /// - Parameter newFacility: Facility selected by the user.
    func updateSelectedFacility(with newFacility: CalendarFacilityViewModel) {
        self.selectedFacility = newFacility
        self.calendarViewModel.getCalendar(for: newFacility.facilityID, newFacility.defaultPrice)
        self.startDate = nil
        self.endDate = nil 
        self.showSaveButton = false 
    }
    
    
    /// Checks for the user selected dates for availability.
    ///  - This method will check for the date interval from start to end if they are not booked so that
    ///  user can change the price or status and enables the save button if dates are available and shows
    ///  a alert dialog if not.
    func checkSelectedDatesForAvailability(){
        if calendarViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
           
            showSaveButton = true 
        } else {
            
            showAlertDialog.toggle()
            priceChangeDialog = true
        }
    }
    
    
    
    /// Handles the day status changes.
    ///  - This method will be invoked whenever the user changes the day status
    ///  in `Calendar Screen`
    /// - Parameter newStatus: new day status selected by the user.
    func handleStatusChange(to newStatus: Status){
        if newStatus != .booked{
            checkSelectedDatesForAvailability()
            self.priceChangeDialog = false 
        }
    }
    
    /// Handles the save button tap.
    /// - This method will be invoked when the user taps on the save button.
    /// This will check the selected dates for availability,
    /// if the price is empty, this will send only the status.
    /// Otherwise, this will send both the price and status to back-end for the selected dates range.
    /// - Parameters:
    ///   - price: Value of the price input field.
    ///   - status: Status of the day status menu.
    func performSaveAction(for price: String, with status: String){
        
        if price.isEmpty {
            if calendarViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
                saveStatus(status)
            }else {
                self.showAlertDialog.toggle()
                self.priceChangeDialog = false
                
            }

        } else {
            if calendarViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
                
                savePriceAndStatus(price, status)
            }else {
                self.showAlertDialog.toggle()
                self.priceChangeDialog = true
                
            }
        }
    }
    
    
    private func saveStatus(_ status: String){
        createReqestBody(for: "", and: status)
    }
    
    /// Creates the POST request body.
    /// - Parameters:
    ///   - price: price selected by the user.
    ///   - status: status selected by the user.
    private func createReqestBody(for price: String, and status: String){
        guard let selectedFacility = selectedFacility, var startDate = startDate, let status = Status(rawValue: status) else {
            return
        }
        
        var requestBody: UpdatedFacilityCalendarDays = []
        
        if endDate != nil {
            
            while(startDate <= endDate!){
                
                let date = DateFormatter.check.string(from: startDate)
                let day = createCalendarDay(for: selectedFacility.facilityID, on: date, with: status, and: price)
                requestBody.append(day)
                print("Day Record \(day)")
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
                
                guard let nextDate = nextDate else {
                    print("next date is nil")
                    return
                }
                print("Next date = \(nextDate)")
                startDate = nextDate
            }
            sendDataToServer(requestBody)
        } else {
            let date = DateFormatter.check.string(from: startDate)
            let day = createCalendarDay(for: selectedFacility.facilityID, on: date, with: status, and: price)
            requestBody.append(day)
            sendDataToServer(requestBody)
        }
    }
    
    private func savePriceAndStatus(_ price: String, _ status: String){
        createReqestBody(for: price, and: status)
    }
    
    private func createCalendarDay(for facilityID: String, on date: String, with status: Status, and price: String) -> UpdatedCalendarDay {
        if price.isEmpty {
            return UpdatedCalendarDay(price: nil, facilityID: facilityID, date: date, status: status.rawValue)
        } else {
            let priceAsInt = Int(price)
            return UpdatedCalendarDay(price: priceAsInt!, facilityID: facilityID, date: date, status: status.rawValue)
        }
    }
    
    private func sendDataToServer(_ data: UpdatedFacilityCalendarDays){
        calendarViewModel.sendUpdatedCalendarDatesToServer(with: data) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Successful")
                    guard let selectedFacility = self?.selectedFacility else {
                        return
                    }

                    self?.calendarViewModel.getCalendar(for: selectedFacility.facilityID, selectedFacility.defaultPrice)
                    self?.startDate = nil
                    self?.endDate = nil
                    self?.showSaveButton.toggle()
                    
                case .failure(_):
                    print("Error")
                }
            }
        }
    }
}

struct CalendarFacilityViewModel: Identifiable {
    let id: String
    private let facility: AvailableFacility
    
    init(_ facility: AvailableFacility){
        self.id = facility.id
        self.facility = facility
    }
    
    var facilityID: String {
        self.facility.id
    }
    
    var name: String {
        self.facility.englishName
    }
    
    var defaultPrice: Int {
        self.facility.price
    }
    
    var address: String {
        self.facility.address
    }
    
    
}

