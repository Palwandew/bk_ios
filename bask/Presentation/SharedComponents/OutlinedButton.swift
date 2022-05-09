//
//  OutlinedButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import SwiftUI

struct OutlinedButton: View {
    
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack{
                Spacer()
                Text(label)
                Spacer()
                Image(systemName: "arrow.right")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(Color(AppColor.DARK_BLUE))
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color(AppColor.DARK_BLUE), lineWidth: 1))
        .padding(.horizontal, 32.0)
        .background(color)
    }
}

struct OutlinedButton_Previews: PreviewProvider {
    static var previews: some View {
        OutlinedButton(label: "I'm owner", color: Color(AppColor.BACKGROUND), action: {
            print("Hi")
        })
    }
}
    
