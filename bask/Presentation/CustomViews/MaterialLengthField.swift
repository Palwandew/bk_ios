//
//  MaterialLengthField.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct MaterialLengthField: View {
    
    @Binding var text: String
    @State var isEditing: Bool = false
    @Binding var isValid: Bool
    @State private var borderColor: Color = Color.gray
    var errorMessage: LocalizedStringKey
    var placeHolder: String
    private let focusedBorderLineWidth: CGFloat = 2
    private let unFocusedBorderLineWidth: CGFloat = 1
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            
            VStack(alignment: .leading) {
                
                TextField(placeHolder, text: $text, onEditingChanged: { (onEditingChange) in
                    isEditing = onEditingChange
                    updateBorder()
                })
                    .font(Font.custom("Poppins-Light", size: 16.0, relativeTo: .headline))
                    .padding()
                    .padding(.trailing, 24)
                    .keyboardType(.numberPad)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(borderColor, lineWidth: isEditing ? 2 : 1)
                    )
                    .onChange(of: isValid) { newValue in
                        updateBorder()
                    }
                
                
                if !isValid{
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(Font.custom("Poppins-Light", size: 12.0, relativeTo: .caption))
                }
            }
            
            HStack{
                Spacer()
                
                Text("m")
                    .font(Font.custom("Poppins-Medium", size: 16.0))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding([.top, .trailing])
                
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
        }.onAppear {
            updateBorder()
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

//struct MaterialLengthField_Previews: PreviewProvider {
//    static var previews: some View {
//        MaterialLengthField()
//    }
//}
