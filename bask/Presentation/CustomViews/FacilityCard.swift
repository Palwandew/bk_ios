//
//  SwiftUIView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct FacilityCard: View {
    
    let facility: UpcomingBookingItemViewModel
    let bannerColor: Color
    

    
    var body: some View {
        
        GeometryReader { geometry in
        ZStack{
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .shadow(radius: 2)
            
            HStack(alignment: .top){
                ImageView(withURL: facility.imageURL, size: CGSize(width: geometry.size.width * 0.40, height: geometry.size.height))
                        .frame(width: geometry.size.width * 0.40, height: geometry.size.height)
                        .cornerRadius(6)
                        .padding([.top, .leading, .bottom], 4)
                                        
                    VStack(alignment: .leading){
                        Text("\(facility.price) currency")
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Spacer()
                        
                        Text(facility.facility)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .lineLimit(2)
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        Text("\(facility.bookedDates)")
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .callout))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            
                    }.padding(.top)
                    .padding(8)
                    Spacer()
                }
            VStack{
                HStack {
                    Spacer()
                    Text(facility.timeRemaining)
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


