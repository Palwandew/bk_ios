//
//  CalendarScreenViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 10/10/2022.
//

import Foundation

class CalendarScreenViewModel: ObservableObject {
    
    private let repository: FacilityDomainReopProtocol
    
    @Published var facilities: [CalendarFacilityViewModel] = []
    
    @Published var selectedFacility: CalendarFacilityViewModel? = nil
    
    @Published var startDate: Date? = nil
    @Published var endDate: Date? = nil
    
    @Published var showAlertDialog: Bool = false
    @Published var priceChangeDialog: Bool = true 
    @Published var showSaveButton: Bool = false
    
    let datesViewModel: CalendarViewModel = CalendarViewModel(repo: CalendarRepositoryImpl())
    
    init(repo: FacilityDomainReopProtocol){
        self.repository = repo
        getAvailableFacilities()
    }
    
    func getAvailableFacilities(){
        self.repository.getAvailableFacilities { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let facilities):
                    self?.facilities = facilities.map(CalendarFacilityViewModel.init)
                    
                    
                    if let firstFacilityFromServer = self?.facilities.first {
                        
                        self?.updateSelectedFacility(with: firstFacilityFromServer)
                        self?.datesViewModel.getCalendar(for: firstFacilityFromServer.facilityID, firstFacilityFromServer.defaultPrice)
                    }
                      
                case .failure(_):
                    print("Error")
                    self?.datesViewModel.state = .failed
                }
            }
            
        }
    }
    
    func isFacilitySelected(_ facilityToCheck: CalendarFacilityViewModel) -> Bool {
        
        return selectedFacility?.facilityID == facilityToCheck.facilityID
    }
    
    func updateSelectedFacility(with newFacility: CalendarFacilityViewModel) {
        self.selectedFacility = newFacility
        self.datesViewModel.getCalendar(for: newFacility.facilityID, newFacility.defaultPrice)
        self.startDate = nil
        self.endDate = nil 
        self.showSaveButton = false 
    }
    
    func checkSelectedDatesForAvailability(){
        if datesViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
            print("Hillo")
            showSaveButton = true 
        } else {
            print("Heehaa")
            showAlertDialog.toggle()
            priceChangeDialog = true
        }
    }
    
    func handleStatusChange(to newStatus: Status){
        if newStatus != .booked{
            checkSelectedDatesForAvailability()
            self.priceChangeDialog = false 
        }
    }
    
    func performSaveAction(for price: String, with status: String){
        
        if price.isEmpty {
            if datesViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
                saveStatus(status)
            }else {
                self.showAlertDialog.toggle()
                self.priceChangeDialog = false
            }

        } else {
            if datesViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
                print("Hii")
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
        datesViewModel.sendUpdatedCalendarDatesToServer(with: data) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Successful")
                    guard let selectedFacility = self?.selectedFacility else {
                        return
                    }

                    self?.datesViewModel.getCalendar(for: selectedFacility.facilityID, selectedFacility.defaultPrice)
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
