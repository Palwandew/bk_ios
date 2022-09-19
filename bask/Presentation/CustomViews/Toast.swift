//
//  Toast.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/08/2022.
//

import SwiftUI

struct Toast: View {
    
    let message: String
    var style: ToastStyle
    
    var body: some View {
        HStack {
            
            Image(systemName: style == .success ? "checkmark.circle.fill" : "exclamationmark.octagon.fill")
                .foregroundColor(Color.white)
                .padding(.leading)
           
            
            Text(message)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .callout))
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
        }
        //.frame(maxWidth: .infinity)
        .background(style == .success ? Color(AppColor.ACCENT_GREEN).cornerRadius(8) : Color(AppColor.RED).cornerRadius(8))
        .padding(.horizontal)
        .padding(.bottom, 64)
    }
    
    
}

enum ToastStyle{
    case success
    case failure
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast(message: "Testing message",style: .failure)
    }
}
