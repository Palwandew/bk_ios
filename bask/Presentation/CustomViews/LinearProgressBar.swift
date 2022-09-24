//
//  LinearProgressBar.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import SwiftUI

struct LinearProgressBar: View {
    @Binding var value: Float
    var background: Color? = nil
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(background != nil ? 1.0 : 0.3)
                    .foregroundColor(background != nil ? background : Color(AppColor.GREY))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
                    .cornerRadius(4.0)
            }.cornerRadius(4.0)
        }
    }
}
