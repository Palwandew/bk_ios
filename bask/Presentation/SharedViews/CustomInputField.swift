//
//  CustomInputField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import SwiftUI

struct CustomInputField: View {
    let placeHolder: String
    @Binding var text: String
    @Binding var isFocused: Bool
    
    var body: some View {
        TextField(
            placeHolder,
            text: $text,
            onEditingChanged: {(editingChanged) in
                isFocused = editingChanged
            }
        ).textFieldStyle(FocusBasedBorderStyle(focused: $isFocused))
        
    }
    
    
}

struct FocusBasedBorderStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(focused ? Color(AppColor.LIGHT_VOILET) : Color(AppColor.GREY), lineWidth: 1)
            )
    }
}


