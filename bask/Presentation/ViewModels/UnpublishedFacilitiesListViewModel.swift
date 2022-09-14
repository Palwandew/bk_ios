//
//  UnpublishedFacilitiesListViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 14/09/2022.
//

import Foundation

class UnpublishedFacilitiesListViewModel: ObservableObject {
    
    @Published var facilities: [UnpublishedFacilityViewModel] = []
    @Published var state: ScreenState = .success
    
    private let repository: FacilityDomainReopProtocol
    
    init(repository: FacilityDomainReopProtocol){
        self.repository = repository
        self.getUnpublishedFacilities()
    }
    
    
    private func getUnpublishedFacilities() {
        
        repository.getUnpublishedFacilities { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let facilities):
                    self?.state = .success
                    self?.facilities = facilities.map(UnpublishedFacilityViewModel.init)
                    
                case .failure(_):
                    print("error occured")
                    self?.state = .failed
                }
            }
        }
    }
}

class UnpublishedFacilityViewModel: Identifiable {
    
    let id: String
    let facility: UnpublishedFacility
    private let localizationHelper: LocalizationHelper
    
    init(facility: UnpublishedFacility) {
        self.id = facility.id
        self.facility = facility
        
        localizationHelper = LocalizationHelper()
        
    }
    
    var name: String {
        return self.facility.englishName
    }
    
    
    var imgURL: String {
        return self.facility.images.first?.photo ?? ""
    }
    
    var progressPercent: String {
        return localizationHelper.getLocalizedNumber(self.facility.progress) + "%"
    }
    
    var progressNumber: Int {
        print("\(Float(self.facility.progress) / 100)")
    
        return self.facility.progress
    }
}
