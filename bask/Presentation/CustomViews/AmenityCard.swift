//
//  AmenityCard.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/09/2022.
//

import SwiftUI

struct AmenityCard: View {
    
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

struct AmenityCard_Previews: PreviewProvider {
    static var previews: some View {
        AmenityCard(icon: "icon_parking", label: "Resort with pools").previewLayout(.sizeThatFits)
    }
}
