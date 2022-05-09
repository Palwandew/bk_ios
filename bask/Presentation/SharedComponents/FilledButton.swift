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
    
    var body: some View {
        
        
        Button(action: {}) {
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
        .padding(.horizontal, 32.0)
        
    }
}

struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        FilledButton(label: "Label", color: Color.red)
            .previewInterfaceOrientation(.portrait)
    }
}
