//
//  MaterialTextSelector.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/08/2022.
//

import SwiftUI

struct MaterialTextSelector: View {
    
    let placeHolder: String
    var body: some View {
        GeometryReader { geomerty in
            ZStack() {
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(AppColor.GREY), lineWidth: 2)
                //.stroke( lineWidth: 1)
                
                HStack{
                    
                    Text(placeHolder)
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.GREY))
                    
                    Spacer()
                    
                    
                    
                }
                .contentShape(Rectangle())
                .padding()
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
            
        }
    }
}
