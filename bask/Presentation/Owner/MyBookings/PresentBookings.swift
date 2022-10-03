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
            if model.upComingBookings.isEmpty {
                
                EmptyState(illustration: "empty_my_bookings", message: "Currently, no bookings in progress.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.presentBookings) { facility in
                            
                            PresentBookingItemCard(model: facility)
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                        }
                    }
                }
            }
            
        case .failed:
            ErrorStateScreen()
        case .initial:
            Text("hi")
        }
        
    }
}


struct PresentBookingItemCard: View {
    
    let model: PresentBookingItemViewModel
    
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
                        Text("\(model.price) currency")
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Spacer()
                        
                        Text(model.name)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .lineLimit(2)
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        Text("\(model.bookedDates)")
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .callout))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            
                    }.padding(.top)
                    .padding(8)
                    Spacer()
                }
            }
        }
    }
}


