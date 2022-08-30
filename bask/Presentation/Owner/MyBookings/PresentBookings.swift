//
//  PresentBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import SwiftUI

struct PresentBookings: View {
    @EnvironmentObject var myBookingsViewModel: MyBookingsViewModel
    @State var upComingBookings: [Int] = []
    var body: some View {
        
        switch myBookingsViewModel.screenState {
        case .loading:
            Spinner()
        case .success:
            if upComingBookings.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Currently, no bookings in progress.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0...upComingBookings.count, id:\.self) { _ in
                            
                            FacilityCard(price: "1600 SAR", name: "Sunny House", bookingDates: "15 Jun - 16 May, 2021; 3 AM", bannerText: "3h : 20m", bannerColor: Color(AppColor.ACCENT_GREEN))
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



