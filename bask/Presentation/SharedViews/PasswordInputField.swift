//
//  PasswordInputField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/05/2022.
//

import SwiftUI

struct PasswordInputField: View {
    
    
    let placeHolder: String
    @State var text: String = ""
    @State private var isEdting: Bool = false
    @State private var strokeColor: Color = Color(AppColor.GREY)
    @State private var error: Bool? = nil
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading){
            
            TextField(
                placeHolder,
                text: $text,
                onEditingChanged: { isEditing in
                    self.strokeColor = Color(AppColor.LIGHT_VOILET)
                    self.isEdting = isEdting
                    print("editing --> \(isEditing)")
                }
            ).textFieldStyle(MaterialUITextInputField(focused: $isEdting, error: $error))
            
            
            Text(placeHolder)
                .foregroundColor(error ?? false ? Color(AppColor.RED) : strokeColor )
                .padding(.horizontal, 5.0)
                .background(Color.white)
                .font(Font.custom("Poppins-Light", size: 12))
                .offset(x: 12 , y: -8)
            
            
            
            
        }
    }
}

struct MaterialUITextInputField: TextFieldStyle {
    @Binding var focused: Bool
    @Binding var error: Bool?
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        
            .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
            .padding()
            .background( error ?? false ?
                         RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color(AppColor.RED), lineWidth: 1) :
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(focused ? Color(AppColor.LIGHT_VOILET) : Color(AppColor.GREY), lineWidth: 1)
                         
            )
    }
}

struct PasswordInputField_Previews: PreviewProvider {
    @State var text = ""
    static var previews: some View {
        PasswordInputField(placeHolder: "Email" )
            .previewInterfaceOrientation(.portrait)
    }
}
