//
//  MaterialTextField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct MaterialTextField: View {
    
    @Binding var text: String
    @Binding var isValid: Bool
    var errorMessage: LocalizedStringKey
    var placeHolder: String
    
    var body: some View {
        VStack(alignment:.leading) {
            
            MaterialDesignTextField(placeHolder: placeHolder, text: $text, isValid: $isValid)
            
            if !isValid{
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(Font.custom("Poppins-Light", size: 12.0, relativeTo: .caption))
            }
        }
    }
}

struct MaterialDesignTextField: View {
    
    var placeHolder: String
    @Binding var text: String
    @State var isEditing: Bool = false
    @Binding var isValid: Bool
    @State var borderColor: Color = Color.gray
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            TextField(placeHolder, text: $text, onEditingChanged: { (onEditingChange) in
                isEditing = onEditingChange
                updateBorder()
            })
                .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(borderColor, lineWidth: isEditing ? 2 : 1)
                )
                .onChange(of: isValid) { newValue in
                    updateBorder()
            }
            
            if !text.isEmpty{
                withAnimation {
                    Text(placeHolder)
                        .font(Font.custom("Poppins-Light", size: 12, relativeTo: .caption))
                        .foregroundColor(borderColor)
                        .padding(.horizontal, 4)
                        .background(Rectangle()
                                        .fill(Color(AppColor.BACKGROUND)))
                        .offset(x: 8, y: -8)
                        .transition(.move(edge: .trailing))
                }
            }
            
        }
        
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

//struct MaterialTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        MaterialTextField(text: "")
//    }
//}
