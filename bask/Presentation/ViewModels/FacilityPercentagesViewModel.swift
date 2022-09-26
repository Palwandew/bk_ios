//
//  FacilityPercentagesViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 26/09/2022.
//

import Foundation

class FacilityPercentagListViewModel: ObservableObject {
    
    private let useCase: GetFacilityPercentagesUsecase
    
    @Published var facilityPercentages: [FacilityPercentageViewModel] = []
    @Published var state: ScreenState = .loading
    
    init(_ useCase: GetFacilityPercentagesUsecase){
        self.useCase = useCase
        getFacilitiesWihtPercentage()
    }
    
    private func getFacilitiesWihtPercentage(){
        useCase.getOwnerFacilitiesPercentage { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_):
                    self?.state = .failed
                case .success(let facilitiesWithPercentage):
                    self?.facilityPercentages = facilitiesWithPercentage.map(FacilityPercentageViewModel.init)
                    self?.state = .success
                }
            }
        }
    }
    
    func tryAgainToGetData(){
        state = .loading
        getFacilitiesWihtPercentage()
    }
    
}

struct FacilityPercentageViewModel: Identifiable{
    
    let id: UUID = UUID()
    private let facilityPercentage: FacilityPercentage
    
    init(_ facilityPercentage: FacilityPercentage){
        self.facilityPercentage = facilityPercentage
    }
    
    var name: String {
        return self.facilityPercentage.name ?? ""
    }
    
    var percentage: Int {
        return self.facilityPercentage.percentage ?? 0
    }
    
    var photoURL: String {
        return self.facilityPercentage.photoURL
    }
}
