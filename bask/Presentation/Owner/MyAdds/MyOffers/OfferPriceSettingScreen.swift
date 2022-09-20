//
//  OfferPriceSettingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct OfferPriceSettingScreen: View {
    
    @State var price: String = ""
    @State var isEditing: Bool = false
    @State var isValid: Bool = true
    
    @State var willShowDurationSetting: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Title
            Text("Set price")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            Text("Set offer  price for your facility")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.horizontal)
                .padding(.bottom)
            
                NavigationLink(isActive: $willShowDurationSetting) {
                    OfferDurationSettingScreen()
                } label: {
                    EmptyView()
                }
            
            
            AvailableFacilityCard(imageURL: "Imag", price: "800 SAR", name: "Blue Lagoon", address: "Al Qatif")
                .frame(height: UIScreen.main.bounds.height * 0.15)
                .padding()
            
            MaterialPriceField(text: $price, isEditing: isEditing, isValid: $isValid, errorMessage: LocalizedStringKey("Error"), placeHolder: "Amount of discount")
                .padding(.horizontal)
                .padding(.top)
            
            Divider()
                .background(Color(AppColor.DARKEST_BLUE))
                .padding()
            
            
                
            Text("New price: \(600) SAR")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
                
            
            Spacer()
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                willShowDurationSetting.toggle()
            }
            .padding(.horizontal)
            
        }
        
        
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OfferPriceSettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OfferPriceSettingScreen()
    }
}
