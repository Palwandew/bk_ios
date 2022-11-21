//
//  AmenityToggleView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/11/2022.
//

import SwiftUI

struct AmenityToggleView: View {
    
    @Binding var isOn: Bool
    let label: String
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16))
                .fontWeight(.regular)
        }.toggleStyle(AccentGreen())
    }
}
