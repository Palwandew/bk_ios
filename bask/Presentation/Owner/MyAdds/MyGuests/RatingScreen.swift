//
//  RatingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct RatingScreen: View {
    
    @EnvironmentObject var model: RatingGuestsViewModel
    
    @State var list = [1]
    @State var willShowRateGuestScreen: Bool = false
    @State var willShowComplainGuestScreen: Bool = false
    @State var guest: UnratedGuestViewModel? = nil
    
    var body: some View {
        
        switch model.state {
            
        case .loading:
            Spinner()
            
        case .success:
            if model.unRatedGuests.isEmpty && model.ratedGuests.isEmpty {
                
                EmptyState(illustration: "empty_guest_illustration", message: "You are not expecting any guests at this moment.")
            }
            else {
                ScrollView{
                    NavigationLink(isActive: $willShowRateGuestScreen) {
                        RateGuestScreen(guest)
                    } label: {
                        EmptyView()
                    }
                    
                    NavigationLink(isActive: $willShowComplainGuestScreen) {
                        ComplainGuestScreen(guest)
                    } label: {
                        EmptyView()
                    }
                    LazyVStack{
                        
                        if !model.unRatedGuests.isEmpty {
                            ForEach(model.unRatedGuests) { model in
                                UnratedGuestListItem(model: model, rateGuest: {
                                    guest = model
                                    willShowRateGuestScreen.toggle()
                                }, complainGuest: {
                                    guest = model
                                    willShowComplainGuestScreen.toggle()
                                })

                            }
                        }
                        
                        if !model.ratedGuests.isEmpty {
                            ForEach(model.ratedGuests) { model in
                                RatedGuestListItem(model: model, viewDetails: {
                                    print("heii")
                                    if model.isRated {
                                        print("inside")
                                        guest = model 
                                        willShowRateGuestScreen = true
                                        
                                    } else {
                                        guest = model 
                                        willShowComplainGuestScreen.toggle()
                                    }
                                })
                            }
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

struct RatingScreen_Previews: PreviewProvider {
    static var previews: some View {
        RatingScreen()
    }
}
