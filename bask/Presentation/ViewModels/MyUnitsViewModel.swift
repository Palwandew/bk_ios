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
    
    @Published var bookedFacility: BookedFacilityViewModel? = nil
    @Published var availableFacility: AvailableFacilityViewModel? = nil 
    
    init(){
        print("MyUnitsViewModel -> init()")
    }
    
    func prepareBookedFacilityForDetailsScreen(facility: BookedFacilityViewModel){
        self.bookedFacility = facility
    }
    
    func prepareAvailableFacilityForDetailsScreen(facility: AvailableFacilityViewModel){
        self.availableFacility = facility
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
    
    private func changeState(state: ScreenState) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.screenState = state
        }
    }
    
    deinit{
        print("MyUnitsViewModel -> deInit()")
    }
}
