//
//  AmenityPaidPriceLengthInputView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct AmenityPriceLengthInputView: View {
    
    @State var text: String = ""
    @State var isValid: Bool = true
    @State var menuShowed: Bool = false
    @State var selectedText: String = "item"
    @State var length: String = ""
    @State var width: String = ""
    @State var validLength: Bool = true
    @State var validWidth: Bool = true
    
    
    var body: some View {
        
        VStack{
            
            HStack {
                MaterialPriceField(text: $text, isValid: $isValid, errorMessage: "required", placeHolder: "Price")
                
                Text("per")
                    .font(Font.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                MaterialDropdown(menuShowed: $menuShowed, selectedText: $selectedText) {
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

struct AmenityPaidPriceLengthInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmenityPriceLengthInputView()
    }
}
