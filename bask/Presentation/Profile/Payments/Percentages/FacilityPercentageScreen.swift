//
//  FacilityPercentageScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct FacilityPercentageScreen: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Percentages")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("The percentage of every renting operation that goes to the Bask")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            LazyVStack(spacing: 16){
                
                PercentageListItem()
                
                PercentageListItem()
                
                PercentageListItem()
                
            }
                
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button{} label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct FacilityPercentageScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPercentageScreen()
    }
}

struct PercentageListItem: View {
    var body: some View {
        HStack{
            
            Image("sample_resort")
                .resizable()
                .scaledToFill()
                .frame(width: 75, height: 65)
                .cornerRadius(6)
            
            Text("Blue Lagoon Resort")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
            
            Spacer()
            
            Text("15%")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
        }
        .padding([.leading, .top, .bottom], 4)
        .padding(.trailing, 8)
        .background(Color.white.cornerRadius(8).shadow(radius: 4))
    }
}
