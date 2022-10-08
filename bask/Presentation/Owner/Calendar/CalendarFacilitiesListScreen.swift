//
//  CalendarFacilitiesListScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/10/2022.
//

import SwiftUI

struct CalendarFacilitiesListScreen: View {
    
    private var viewModel: UpcomingBookingItemViewModel = UpcomingBookingItemViewModel(facility: UpcomingBooking(id: 301, price: 300, bookingDates: BookingDates(startDate: "2022-10-20", endDate: "2022-10-24"), englishName: "Mountaina", checkInAfter: "12:00 PM", remainingTime: RemainingTime(days: 3, hours: 3, minutes: 2), facility: UpcomingBookingFacility(id: "20", images: [FacilityImage(photo: "fakeUrl")]), bookingstatus: UpcomingBookingstatus(statusName: "accepted")))
    
    @State var facilities: [Int] = [1, 3]
    
    @State var startDate: Date? = nil
    @State var endDate: Date? = nil
    @State var showCalendar: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Group {
                Text("Facilities")
                    .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Text("Select your facility to check its calendar")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                 
            }.padding(.horizontal)
            
            NavigationLink(isActive: $showCalendar) {
                CalendarViews(startDate: $startDate, endDate: $endDate)
            } label: {
                EmptyView()
            }

            Spacer()
            
            ScrollView {
                LazyVStack(spacing: 16){
                    ForEach(facilities, id:\.self) { facility in
                        
                        FacilityCard(facility: viewModel, bannerColor: Color(AppColor.LIGHT_VOILET))
                            .frame(height: UIScreen.main.bounds.height * 0.15)
                            .padding()
                            .onTapGesture {
                                //CalendarViews(startDate: $startDate, endDate: $endDate)
                                print("Show calendar")
                                showCalendar.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct CalendarFacilitiesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarFacilitiesListScreen()
    }
}
