//
//  UpcomingBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct UpcomingBookings: View {
    @EnvironmentObject var myBookingsViewModel: MyBookingsViewModel
    @State var upComingBookings: [Int] = []
    var body: some View {
        
        switch myBookingsViewModel.screenState {
        case .loading:
            Spinner()
        case .success:
            if upComingBookings.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Unfortunately, there are no upcoming bookings yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0...upComingBookings.count, id:\.self) { _ in
                            
                            FacilityCard(price: "1600 SAR", name: "Sunny House", bookingDates: "15 Jun - 16 May, 2021; 3 AM", bannerText: "3h : 20m", bannerColor: Color(AppColor.LIGHT_VOILET))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                        }
                    }
                }.background(Color.white)
            }
            
        case .failed:
            Text("error occured")
        }
        
    }
}

struct UpcomingBookings_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingBookings()
    }
}
