//
//  MaterialSecureField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 27/07/2022.
//

import SwiftUI

struct MaterialSecureField: View {
    
    @Binding var text: String
    @Binding var isEditing: Bool
    @Binding var isValid: Bool
    @State private var borderColor: Color = Color.gray
    @State var showPassword: Bool = false
    var errorMessage: LocalizedStringKey
    var placeHolder: String
    private let focusedBorderLineWidth: CGFloat = 2
    private let unFocusedBorderLineWidth: CGFloat = 1
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            
            VStack(alignment: .leading) {
                if !showPassword {
                    SecureField(placeHolder, text: $text, onCommit: { isEditing = false })
                    .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(borderColor, lineWidth: isEditing ? focusedBorderLineWidth : unFocusedBorderLineWidth)
                    )
                    .onChange(of: isEditing) { newValue in
                        updateBorder()
                    }
                    .onTapGesture {
                        isEditing = true
                    }
                    .onChange(of: isValid) { newValue in
                        updateBorder()
                }
                } else {
                    TextField(placeHolder, text: $text)
                        .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(borderColor, lineWidth: isEditing ? 2 : 1)
                        )
                }
                
                if !isValid{
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(Font.custom("Poppins-Light", size: 12.0, relativeTo: .caption))
                }
            }
            
            HStack{
                Spacer()
                Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 20)
                    .padding([.top, .trailing])
                    .onTapGesture {
                        showPassword.toggle()
                    }
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
                        .transition(.opacity)
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

//struct MaterialSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        MaterialSecureField()
//    }
//}
