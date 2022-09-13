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
        
        repository.getAvailableFacilities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let facilities):
                    self?.state = .success
                    self?.facilities = facilities.map(AvailableFacilityViewModel.init)
                    
                case .failure(_):
                    print("error occured")
                    self?.state = .failed
                }
            }
        }
    }
}

class AvailableFacilityViewModel: Identifiable {
    
    let id: String
    let facility: AvailableFacility
    private let localizationHelper: LocalizationHelper
    
    init(facility: AvailableFacility) {
        self.id = facility.id
        self.facility = facility
        
        localizationHelper = LocalizationHelper()
        
    }
    
    var name: String {
        return self.facility.englishName
    }
    
    var price: String {
        
        return localizationHelper.getLocalizedNumber(self.facility.price)
    }
    
    var imgURL: String {
        return self.facility.images.first?.photo ?? ""
    }
    
    var address: String {
        return self.facility.address
    }
}

