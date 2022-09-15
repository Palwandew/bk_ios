//
//  RatingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct RatingScreen: View {
    
    @State var list = [1]
    @State var willShowRateGuestScreen: Bool = false
    @State var willShowComplainGuestScreen: Bool = false
    
    var body: some View {
        
        if list.isEmpty {
            EmptyState(illustration: "empty_rating_illustration", message: "You don't have any rating yet.")
        } else {
            
            

            ScrollView{
                LazyVStack{
                    NavigationLink(isActive: $willShowRateGuestScreen) {
                        RateGuestScreen()
                    } label: {
                        EmptyView()
                    }
                    ForEach(0..<list.count, id:\.self) { _ in
                        GuestRatingListItem {
                            willShowRateGuestScreen.toggle()
                        } complainGuest: {
                            willShowComplainGuestScreen.toggle()
                        }

                    }
                }
            }
        }
    }
}

struct RatingScreen_Previews: PreviewProvider {
    static var previews: some View {
        RatingScreen()
    }
}
