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
    
    func performSaveAction(with price: String, and status: String){
        /// if everything is ok save changes else throw exceptoin
        if price.isEmpty {
            
        }
        
    }
    
    private func saveStatus(){
        print("Status")
    }
    
    private func savePriceWithStatus(){
        
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
