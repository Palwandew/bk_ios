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
    
    @Published var showAlertDialog: Bool = false
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
        self.showSaveButton = false 
    }
    
    func checkSelectedDatesForAvailability(_ startDate: Date?, _ endDate: Date?){
        if datesViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
            print("Hillo")
            showSaveButton = true 
        } else {
            print("Heehaa")
            showAlertDialog.toggle()
        }
    }
    
    func performSaveAction(for price: String, with status: String, from startDate: Date?, to endDate: Date?){
        
        if price.isEmpty {
            saveStatus(status, from: startDate, to: endDate)
        } else {
            if datesViewModel.isDateRangeAvailable(from: startDate, to: endDate) {
                savePriceAndStatus(price, status)
            }
        }
    }
    
    private func saveStatus(_ status: String, from startDate: Date?, to endDate: Date?){
        guard let selectedFacility = selectedFacility, var startDate = startDate, let status = Status(rawValue: status) else {
            return 
        }
        
        var requestBody: GetFacilityCalendarDays = []
        let date = DateFormatter.check.string(from: startDate)
        if endDate != nil {
            
            while(startDate <= endDate!){
                
                
                let day = createCalendarDay(for: selectedFacility.facilityID, on: date, with: status)
                requestBody.append(day)
                print("Day Record \(day)")
                let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
                guard let nextDate = nextDate else {
                    return
                }
                
                startDate = nextDate
            }
            sendDataToServer(requestBody)
        } else {
        
            let day = createCalendarDay(for: selectedFacility.facilityID, on: date, with: status)
            requestBody.append(day)
            sendDataToServer(requestBody)
        }
    }
    
    private func savePriceAndStatus(_ price: String, _ status: String){
        print("Price \(price) and \(status)")
    }
    
    private func createCalendarDay(for facilityID: String, on date: String, with status: Status) -> UpdatedCalendarDay {
        
        return UpdatedCalendarDay(facilityID: facilityID, date: date, status: status.rawValue)
    }
    
    private func sendDataToServer(_ data: GetFacilityCalendarDays){
        datesViewModel.sendUpdatedCalendarDatesToServer(with: data) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Successful")
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
