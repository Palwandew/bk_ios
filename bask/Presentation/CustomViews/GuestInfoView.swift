//
//  GuestInfoView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - GuestInfoView
struct GuestInfoView: View {
    
    let name: String
    let rating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.gray).frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Guest")
                        .font(Font.custom("Poppins-Regular", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    Text(name)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
                
                Spacer()
                
                Text(rating)
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
            }
            
            
            
            HStack{
                
                Image("icon_complain")
                    .resizable()
                    .frame(width: 24, height: 24)
                
                Text("Complain")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image(systemName: "arrow.right")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
            }
            
            Divider().padding(.vertical)
            
            ArrivalDetailsView()
            
            
        }
    }
}
