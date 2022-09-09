//
//  FacilityAmenitiesView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

struct FacilityAmenitiesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Amenities")
                .font(Font.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16){
                    
                    AmenityCard(icon: "icon_parking", label: "Parking")
                    
                    AmenityCard(icon: "icon_parking", label: "WiFi")
                    
                    AmenityCard(icon: "icon_parking", label: "Indoor pool")
                    
                    AmenityCard(icon: "icon_parking", label: "Barbeque")
                    
                    AmenityCard(icon: "icon_parking", label: "Barbeque")
                    
                }
                .padding(2)
                
            }
        }
    }
    
    
}

private struct AmenityCard: View {
    
    let icon: String
    let label: String
    
    var body: some View {
            
            VStack{
                
                Image(icon)
                  
                Text(label)
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 1)
                    
                
            }
            .frame(width: 84, height: 104)
            .background(Color(AppColor.BACKGROUND))
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}
