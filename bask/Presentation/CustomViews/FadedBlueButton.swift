//
//  FadedBlueButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - FaddedBlueButton
struct FadedBlueButton: View {
    let icon: String
    let action: () -> Void
    var body: some View {
        GeometryReader { geomerty in
            
            Button {
                action()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(AppColor.DARK_BLUE).opacity(0.5))
                        .frame(width: geomerty.size.width, height: geomerty.size.height)
                    
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .rotationEffect(icon.elementsEqual("ellipsis") ? .degrees(90) : .degrees(0))
                }
            }
            
            
        }
    }
}
