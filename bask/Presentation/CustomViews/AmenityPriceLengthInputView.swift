//
//  AmenityPaidPriceLengthInputView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct AmenityPriceLengthInputView: View {
    
    @Binding var text: String
    @Binding var isValid: Bool
    @State var menuShowed: Bool = false
    @State var selectedText: String = "item"
    @Binding var length: String
    @Binding var width: String
    @Binding var validLength: Bool
    @Binding var validWidth: Bool
    
    
    var body: some View {
        
        VStack{
            
            HStack {
                MaterialPriceField(text: $text, isValid: $isValid, errorMessage: "required", placeHolder: "Price")
                
                Text("per")
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                MaterialDropdown(menuShowed: $menuShowed, selectedText: selectedText) {
                    print("hee")
                    menuShowed.toggle()
                }.frame(height: 57)
            }
            
            HStack {
                MaterialLengthField(text: $length, isValid: $validLength, errorMessage: "valid_room_length", placeHolder: "x-meters")
                
                Image(systemName: "multiply")
                    .padding(.horizontal, 4)
                
                MaterialLengthField(text: $width, isValid: $validWidth, errorMessage: "valid_room_length", placeHolder: "y-meters")
            }
        }.padding(.leading, 1)
    }
}

//struct AmenityPaidPriceLengthInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        AmenityPriceLengthInputView()
//    }
//}
