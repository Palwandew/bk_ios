//
//  NewPromoCodeScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct NewPromoCodeScreen: View {
    
    
    var body: some View {
        VStack(alignment: .leading){
        ScrollView(.vertical, showsIndicators: false) {
            
                
                NewPromoCard()
                    .padding(.top, 4)
                    .padding(.horizontal, 4)
                
                HStack(alignment: .top) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Promo code rule")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                }
                
                
                
                
                
        }
            Spacer()
            FilledButton(label: "create promo", color: Color(AppColor.DARKEST_BLUE)) {
                print("Create code.")
            }
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
    }
}

struct NewPromoCodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewPromoCodeScreen()
    }
}

struct NewPromoCard: View {
    
    @State var text = ""
    @State var isValid = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            MaterialPriceField(text: $text, isValid: $isValid, errorMessage: LocalizedStringKey("error"), placeHolder: "Amount of discount")
            MaterialPriceField(text: $text, isValid: $isValid, errorMessage: LocalizedStringKey("error"), placeHolder: "Expiration date", endIcon: "calendar")
            MaterialPriceField(text: $text, isValid: $isValid, errorMessage: LocalizedStringKey("error"), placeHolder: "Maximum people", endIcon: "person.fill")
            Text("maximum_people")
                .font(.custom("Poppins-Regular", size: 12, relativeTo: .callout))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            Divider()
                .padding(.vertical, 4)
            
            
            MaterialPriceField(text: $text, isValid: $isValid, errorMessage: LocalizedStringKey("error"), placeHolder: "Code name e.g SUPER 15", endIcon: "qrcode")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8, style: .circular).fill(Color.white).shadow(radius: 4))
    }
}
