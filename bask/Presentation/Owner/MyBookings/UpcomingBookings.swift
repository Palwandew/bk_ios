//
//  UpcomingBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct UpcomingBookings: View {
    @EnvironmentObject var model: MyBookingsViewModel
    @State var upComingBookings: [Int] = []
    var body: some View {
        
        switch model.screenState {
        case .loading:
            Spinner()
        case .success:
            if model.facilities.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Unfortunately, there are no upcoming bookings yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.facilities) { facility in
                            
                            FacilityCard(facility: facility, bannerColor: Color(AppColor.LIGHT_VOILET))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                        }
                    }
                }.background(Color.white)
            }
            
        case .failed:
            Text("error occured")
        case .initial:
            Text("hi")
        }
        
    }
}

struct UpcomingBookings_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBookings()
    }
}
