//
//  AmenityCounterButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct AmenityCounterButton: View {
    
    let systemName: String
    let onTapped: () -> Void
    var body: some View {
            
            Button {
                onTapped()
            } label: {
                ZStack{
                    Circle()
                        .fill(Color(AppColor.COUNTER_GREY))
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: systemName)
                        .resizable()
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .frame(width: 8, height: (systemName == "minus" ? 1.14 : 8))
                        .padding()
                }
            }
    }
}

struct AmenityCounterButton_Previews: PreviewProvider {
    static var previews: some View {
        AmenityCounterButton(systemName: "plus") {
            print("hello")
        }
    }
}
