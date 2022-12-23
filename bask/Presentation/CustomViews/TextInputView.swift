//
//  TextInputView.swift
//  bask
//
//  Created by MapMac on 22/12/2022.
//

import SwiftUI

struct TextInputView: View {
    
    @Binding var text: String
    let isFocused: Bool
    @State private var borderColor: Color = Color(AppColor.GREY)
    
    
    var body: some View {
        TextField("", text: $text)
            .font(.custom("Poppins-Regular", size: 16))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke( isFocused ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.GREY), lineWidth: isFocused ? 2 : 1)
                    .animation(.linear, value: isFocused)
            )
            
    }
}

struct SecuredTextInputView: View {
    
    @Binding var text: String
    let isFocused: Bool
    
    @State private var borderColor: Color = Color(AppColor.GREY)
    
    var body: some View {
        SecureField("", text: $text)
            .font(.custom("Poppins-Regular", size: 16))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke( isFocused ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.GREY), lineWidth: isFocused ? 2 : 1)
                    .animation(.linear, value: isFocused)
            )
    }
}

//struct TextInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextInputView()
//    }
//}
