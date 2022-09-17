//
//  RateGuestViewModel.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 18/09/2022.
//

import Foundation

class RateGuestViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    let unratedGuest: UnratedGuestViewModel
    
    init(_ unratedGuest: UnratedGuestViewModel){
        
        self.unratedGuest = unratedGuest
    }
}
