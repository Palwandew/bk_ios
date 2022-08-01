//
//  AmenityCounterView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 02/08/2022.
//

import SwiftUI

struct AmenityCounterView: View {
    @Binding var counter: Int
    let label: String
    let onDecrease: () -> Void
    let onIncrease: () -> Void
    
    var body: some View {
        HStack{
            
            Text(label)
                .font(Font.custom("Poppins-Medium", size: 16.0))
            
            Spacer()
            
            AmenityCounterButton(systemName: "minus") {
                onDecrease()
            }.frame(width: 24, height: 24)
            
            Text("\(counter)")
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .font(Font.custom("Poppins-Medium", size: 14.0))
            
            AmenityCounterButton(systemName: "plus") {
                onIncrease()
            }.frame(width: 24, height: 24)
        }
    }
}

//struct AmenityCounterView_Previews: PreviewProvider {
//    static var previews: some View {
//        AmenityCounterView(label: "Living rooms", onDecrease: {
//            print("-")
//        }, onIncrease: {
//            print("+")
//        })
//    }
//}
