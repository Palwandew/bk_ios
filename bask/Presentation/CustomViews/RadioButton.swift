//
//  RadioButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct RadioButton: View {
    
    var checked: Bool
    
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 20, height: 20)
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
            
            if checked{
                Circle()
                    .fill(Color(AppColor.ACCENT_GREEN))
                    .frame(width: 10, height: 10)
            }
        }
    }
}

