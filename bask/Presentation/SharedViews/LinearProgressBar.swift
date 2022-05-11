//
//  LinearProgressBar.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 11/05/2022.
//

import SwiftUI

struct LinearProgressBar: View {
    @Binding var value: Float
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(AppColor.GREY))
                
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
            }.cornerRadius(4.0)
        }
    }
}


