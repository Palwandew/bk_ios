//
//  MaterialPhoneField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct MaterialPhoneNumberField: View {
    
    @Binding var text: String
    @Binding var isValid: Bool
    @State var isEditing: Bool = false
    var errorMessage: String
    var placeHolder: String
    var countryCallingCode: String
    var onCountryCodeSelector: () -> ()
    var body: some View {
        VStack(alignment:.leading) {
            
            MaterialDesignTextField(isValid: $isValid, text: $text, isEditing: $isEditing, placeHolder: placeHolder, countryCode: countryCallingCode,onCountryCodeSelector: onCountryCodeSelector)
            
            if !isValid{
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(Font.custom("Poppins-Light", size: 12.0, relativeTo: .caption))
            }
        }
    }
    
    
    struct MaterialDesignTextField: View {
        
        @Binding var isValid: Bool
        @Binding var text: String
        @Binding var isEditing: Bool
        @State var borderColor: Color = Color.gray
        var placeHolder: String
        var countryCode: String
        var onCountryCodeSelector: () -> ()
        var body: some View {
            
            HStack{
                Group {
                    Text(countryCode)
                        .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
                        .padding(.leading)
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(AppColor.LIGHT_VOILET))
                    
                    Rectangle()
                        .fill((Color(AppColor.LIGHT_VOILET)))
                        .frame(width: 3, height: 30)
                }.onTapGesture {
                    onCountryCodeSelector()
                }
                
                
                
                TextField(placeHolder, text: $text, onEditingChanged: { (onEditingChange) in
                    isEditing = onEditingChange
                    updateBorder()
                }).padding()
                    .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
            }
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(borderColor, lineWidth: 2))
            .onChange(of: isValid) { newValue in
                updateBorder()
            }
            
            
            
            //            ZStack(alignment: .topLeading) {
            //                TextField(placeHolder, text: $text, onEditingChanged: { (onEditingChange) in
            //                    isEditing = onEditingChange
            //                    updateBorder()
            //                })
            //                    .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
            //                    .padding()
            //                    .background(
            //                        RoundedRectangle(cornerRadius: 10, style: .continuous)
            //                            .stroke(borderColor, lineWidth: isEditing ? 2 : 1)
            //                    )
            //                    .onChange(of: isValid) { newValue in
            //                        updateBorder()
            //                }
            //
            //                if !text.isEmpty{
            //                    withAnimation {
            //                        Text(placeHolder)
            //                            .font(Font.custom("Poppins-Light", size: 12, relativeTo: .caption))
            //                            .foregroundColor(borderColor)
            //                            .padding(.horizontal, 4)
            //                            .background(Rectangle()
            //                                            .fill(Color(AppColor.BACKGROUND)))
            //                            .offset(x: 8, y: -8)
            //                            .transition(.opacity)
            //                    }
            //                }
            //
            //            }
            
        }
        
        private func updateBorder(){
            if !isValid {
                borderColor = .red
                return
            }
            if isEditing {
                borderColor = Color(AppColor.LIGHT_VOILET)
                return
            }
            borderColor = Color(AppColor.GREY)
        }
    }
}

//struct MaterialPhoneField_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        MaterialPhoneNumberField(errorMessage: "errorMe", placeHolder: "123-456-789")
//    }
//}
