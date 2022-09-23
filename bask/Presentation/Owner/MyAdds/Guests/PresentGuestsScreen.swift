//
//  PresentGuestsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct PresentGuestsScreen: View {
    
    @EnvironmentObject var model: PresentGuestsViewModel
    
    var body: some View {
        
        switch model.state {
            
        case .loading:
            Spinner()
            
        case .success:
            if model.presentGuests.isEmpty {
                
                EmptyState(illustration: "empty_guest_illustration", message: "You are not expecting any guests at this moment.")
            }
            else {
                ScrollView{
                    
                    LazyVStack {
                        ForEach(model.presentGuests){ guest in
                            MyGuestListItem(guest.facilityName, guest.facilityAddress, guest.chechInTime, guest.checkOutTime, guest.name)
                        }
                    }
                }
            }
            
        case .failed:
            ErrorStateScreen()
            
        case .initial:
            EmptyView()
        }
    }
}


struct PresentGuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        PresentGuestsScreen()
    }
}
