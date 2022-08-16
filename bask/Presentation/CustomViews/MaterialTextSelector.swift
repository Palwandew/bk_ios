//
//  MaterialTextSelector.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/08/2022.
//

import SwiftUI

struct MaterialTextSelector: View {
    
    @Binding var text: String
    let placeHolder: String
    var body: some View {
        GeometryReader { geomerty in
            ZStack() {
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                //.stroke( lineWidth: 1)
                
                HStack{
                    
                    Text(text.isEmpty ? placeHolder : text)
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(text.isEmpty ? Color(AppColor.GREY) : Color(AppColor.DARKEST_BLUE))
                    
                    Spacer()
                    
                    
                    
                }
                .contentShape(Rectangle())
                .padding()
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
            
        }
    }
}
