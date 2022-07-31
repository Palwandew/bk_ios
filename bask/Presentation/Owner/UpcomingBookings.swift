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
            Text("Loading")
        case .success:
            if upComingBookings.isEmpty {
                VStack{
                    Image("empty_my_bookings")
                    Text("Unfortunately, there are no upcoming bookings yet.")
                        .multilineTextAlignment(.center)
                        .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.horizontal)
                }
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0...6, id:\.self) { _ in
                            
                            FacilityCard(price: "1600 SAR", name: "Sunny House", bookingDates: "15 Jun - 16 May, 2021; 3 AM", bannerText: "3h : 20m", bannerColor: Color(AppColor.LIGHT_VOILET))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                        }
                    }
                }
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
