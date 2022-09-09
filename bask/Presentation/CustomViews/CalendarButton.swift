//
//  CalendarButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - CalendarButton
struct CalendarButton: View {
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Calendar")
                .font(Font.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Button {
                print("Calendar gooo")
            } label: {
                HStack{
                    
                    Text("View")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
        }.padding(.horizontal)
    }
}
