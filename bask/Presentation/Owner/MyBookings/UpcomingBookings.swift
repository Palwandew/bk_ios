//
//  UpcomingBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct UpcomingBookings: View {
    @EnvironmentObject var model: MyBookingsViewModel
    @State var showAcceptBookingDialog: Bool = false
    var body: some View {
        
        switch model.screenState {
        case .loading:
            Spinner()
        case .success:
            if model.upComingBookings.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Unfortunately, there are no upcoming bookings yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.upComingBookings) { facility in
                            
                            FacilityCard(facility: facility, bannerColor: Color(AppColor.LIGHT_VOILET))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                                .onTapGesture {
                                    if facility.status == .pending {
                                        model.prepareFacilityForConfirmationDialog(facility)
                                        showAcceptBookingDialog.toggle()
                                    }
                                }
                            
                        }
                    }
                }.background(Color.white)
                    .fullScreenCover(isPresented: $showAcceptBookingDialog) {
                        BookingConfirmationDialogScreen(model: model)
                    }
            }
            
        case .failed:
            ErrorStateScreen {
                print("retry")
            }
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
