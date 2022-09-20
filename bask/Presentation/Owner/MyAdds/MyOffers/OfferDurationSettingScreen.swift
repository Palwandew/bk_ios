//
//  OfferDurationSettingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct OfferDurationSettingScreen: View {
    
    @State var show: Bool = false
    @State var text: String = "Dec 13"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Title
            Text("Set duration")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            Text("Set offer duration for your facility")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.horizontal)
                .padding(.bottom)
            
            //MARK: - Facility Card
            AvailableFacilityCard(imageURL: "Imag", price: "800", name: "Blue Lagoon", address: "Al Qatif")
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .padding()
            
//            MaterialPriceField(text: $price, isEditing: isEditing, isValid: $isValid, errorMessage: LocalizedStringKey("Error"), placeHolder: "Amount of discount")
//                .padding(.horizontal)
//                .padding(.top)
                
            
            //MARK: - Offer duration
            Text("Duration of offer")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            
            //MARK: - Offer duration input
            HStack {
                MaterialDropdown(menuShowed: $show, selectedText: $text, icon: "calendar") {
                    
                }

                Text("to")
                    .font(.custom("Poppins-Regular", size: 16))
                
                MaterialDropdown(menuShowed: $show, selectedText: $text, icon: "calendar") {
                    
                }
            }.frame(height: UIScreen.main.bounds.height * 0.07)
                .padding(.horizontal)
                
            
            Spacer()
            
            FilledButton(label: "Create offer", color: Color(AppColor.DARKEST_BLUE)) {
                //willShowDurationSetting.toggle()
                show.toggle()
            }
            .padding(.horizontal)
            
        }
        .sheet(isPresented: $show, content: {
            CalendarViews()
        })
        .navigationBarTitleDisplayMode(.inline)
    } 
}

struct OfferDurationSettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OfferDurationSettingScreen()
        
//        OfferDurationSettingScreen().environment(\.locale, .init(identifier: "ar") )
//            .environment(\.layoutDirection, .rightToLeft)
        
        
    }
}
