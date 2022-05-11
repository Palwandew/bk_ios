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
        .foregroundColor(Color.white)
        .background(color)
        .cornerRadius(8)
        
    }
}
