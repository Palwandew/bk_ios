//
//  PresentBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import SwiftUI

struct PresentBookings: View {
    @EnvironmentObject var model: MyBookingsViewModel
    @State var upComingBookings: [Int] = []
    var body: some View {
        
        switch model.screenState {
        case .loading:
            Spinner()
        case .success:
            if model.facilities.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Currently, no bookings in progress.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.facilities) { facility in
                            
                            FacilityCard(facility: facility, bannerColor: Color(AppColor.ACCENT_GREEN))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                        }
                    }
                }
            }
            
        case .failed:
            Text("error occured")
        case .initial:
            Text("hi")
        }
        
    }
}



