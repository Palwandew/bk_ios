//
//  SwiftUIView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct FacilityCard: View {
    
    let price: String
    let name: String
    let bookingDates: String
    let bannerText: String
    let bannerColor: Color
    
    var body: some View {
        
        GeometryReader { geometry in
        ZStack{
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .shadow(radius: 2)
            
            HStack(alignment: .top){
                    Image("sample_resort")
                        .resizable()
                        
                        .frame(width: geometry.size.width * 0.40, height: geometry.size.height)
                        .cornerRadius(6)
                        .padding([.top, .leading, .bottom], 4)
                                        
                    VStack(alignment: .leading){
                        Text(price)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Spacer()
                        
                        Text(name)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        Text(bookingDates)
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .callout))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            
                    }.padding(.top)
                    .padding(8)
                    Spacer()
                }
            VStack{
                HStack {
                    Spacer()
                    Text(bannerText)
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


