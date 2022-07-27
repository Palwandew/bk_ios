//
//  PasswordInputField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 13/05/2022.
//

import SwiftUI

struct PasswordInputField: View {
    
    
    let placeHolder: String
    @Binding var text: String
    @Binding var isEdting: Bool
    @State private var strokeColor: Color = Color(AppColor.GREY)
    @Binding var error: Bool?
    @State var showPassword: Bool = false
    let isSecure: Bool
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading){
            
            
            if !isSecure{
                TextField(
                    placeHolder,
                    text: $text,
                    onEditingChanged: { (isEditing) in
                        isEdting = isEditing
                        
                    }
                ).textFieldStyle(MaterialUITextInputField(focused: $isEdting, error: $error))
//                    .overlay(alignment: .trailing){
//
//                        Button{
//                            print("show password tapped")
//                            showPassword.toggle()
//                        } label: {
//                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill" )
//                                .padding(.horizontal, 8.0)
//                                .foregroundColor(Color(AppColor.DARK_BLUE))
//                        }
//                    }
            } else {
                SecureField(
                    placeHolder,
                    text: $text
                    
                ).textFieldStyle(MaterialUITextInputField(focused: $isEdting, error: $error))
//                    .overlay(alignment: .trailing){
//                        
//                        Button{
//                            print("show password tapped")
//                            showPassword.toggle()
//                        } label: {
//                            Image(systemName: "eye.fill")
//                                .padding(.horizontal, 8.0)
//                                .foregroundColor(Color(AppColor.DARK_BLUE))
//                        }
//                    }
            }
            
            
                
        
            
            
            Text(placeHolder)
                .foregroundColor(error ?? false ? Color(AppColor.RED) : Color(AppColor.LIGHT_VOILET) )
                .padding(.horizontal, 5.0)
                .background(Color.white)
                .font(Font.custom("Poppins-Light", size: 12))
                .offset(x: 12 , y: -8)
                .transition(.move(edge: Edge.bottom))
            
            
            
            
            
            
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


private func changeTextToMask(text: String) -> String{
    //let len = text.count
    for i in text {
        print(i)
    }
    
    return "*****"
}
