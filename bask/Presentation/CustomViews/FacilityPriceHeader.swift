//
//  FacilityPriceHeader.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - FacilityPriceHeader
struct FacilityPriceHeader: View {
    let price: String
    let rating: String
    let status: FacilityDetailsStyle
    
    var body: some View {
        HStack {
            Text("\(price) SAR")
                .font(.custom("Poppins-Medium", size: 16, relativeTo: .body))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("per night")
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            Divider()
                .frame(height: 32)
            Text("\(rating)")
                .font(Font.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            Spacer()
            
            switch status {
            case .booked:
                Text("Booked")
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image("icon_booked_calendar")
                    .foregroundColor(.blue)
            case .available:
                Text("Available")
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image(systemName: "calendar")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }
            
        }
    }
}
