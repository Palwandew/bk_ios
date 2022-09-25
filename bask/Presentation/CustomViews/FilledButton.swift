//
//  FilledButton.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import SwiftUI

struct FilledButton: View {
    
    let label: String
    let color: Color
    var endIcon: String? = nil
    let action: () -> Void
    
    var body: some View {
        
        
        Button(action: action) {
            HStack{
                Spacer()
                Text(LocalizedStringKey(label))
                    .font(Font.custom("Poppins-Regular", size: 16))
                Spacer()
                Image(systemName: endIcon ?? "arrow.forward")
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(Color.white)
        .background(color)
        .cornerRadius(8)
        
    }
}
