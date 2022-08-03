//
//  Checkbox.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct Checkbox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label.font(Font.custom("Poppins-Regular", size: 16))
            Spacer()
            if configuration.isOn {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .cornerRadius(5)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                
            } else {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                
            }
        }
    }
}

