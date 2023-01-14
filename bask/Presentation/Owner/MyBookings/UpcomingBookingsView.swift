//
//  UpcomingBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct UpcomingBookingsView: View {
    @EnvironmentObject var model: MyBookingsViewModel
    @State private var showAcceptBookingDialog: Bool = false
    
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
                        ForEach(model.upComingBookings) { item in
                            
                            BookingCardView(model: item, bannerColor: .blue)
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            //                                .onTapGesture {
                            //                                    if facility.status == .pending {
                            //                                        model.prepareFacilityForConfirmationDialog(facility)
                            //                                        showAcceptBookingDialog.toggle()
                            //                                    }
                            //                                }
                            
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

//struct UpcomingBookings_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingBookingsView()
//    }
//}

//struct BookingCardView_Previews: PreviewProvider {
//    static let facility = UpcomingBooking(id: UUID().uuidString, facilityImage: "fake-img-url", facilityName: "Shul-e-Yal", price: 300.0, checkInDate: .now, checkOutDate: .distantFuture)
//
//    static var previews: some View {
//        BookingCardView(facility: facility, bannerColor: .blue).previewLayout(.sizeThatFits)
//    }
//}

struct BookingCardView: View {
    
    
    let model: UpcomingBookingItemViewModel
    let bannerColor: Color
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 2)
                
                HStack(alignment: .top){
                    ImageView(withURL: model.imageURL, size: CGSize(width: geometry.size.width * 0.40, height: geometry.size.height))
                        .frame(width: geometry.size.width * 0.40, height: geometry.size.height)
                        .cornerRadius(6)
                        .padding([.top, .leading, .bottom], 4)
                    
                    VStack(alignment: .leading){
                        Text(model.price)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Spacer()
                        
                        Text(model.facility)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .lineLimit(2)
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        Text(model.bookedDates)
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .callout))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                    }.padding(.top)
                        .padding(8)
                    Spacer()
                }
                
                VStack{
                    HStack {
                        Spacer()
                        Text(model.timeRemaining)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 10, relativeTo: .callout))
                            .padding(8)
                            .background(bannerColor)
                            .roundCorners(radius: 8, [.topRight, .bottomLeft])
                        
                    }
                    Spacer()
                }
            }
        }
    }
}
