//
//  PastBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import SwiftUI

struct PastBookings: View {
    @EnvironmentObject var model: MyBookingsViewModel
    @State var upComingBookings: [Int] = []
    var body: some View {
        
        switch model.screenState {
        case .loading:
            Spinner()
        case .success:
            if model.facilities.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Unfortunately, there are no past bookings.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.facilities) { facility in
                            
                            FacilityCard(facility: facility, bannerColor: Color(AppColor.RED))
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
