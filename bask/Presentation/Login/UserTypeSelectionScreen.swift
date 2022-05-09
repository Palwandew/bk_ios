//
//  UserTypeSelectionScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/05/2022.
//

import SwiftUI

struct UserTypeSelectionScreen: View {
    var body: some View {
        
        VStack(spacing: 16.0){
            HStack{
                VStack(alignment: .leading) {
                    
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 90.0, height: 90.0)
                        .padding(.leading, -18)
                        .padding(.top, 32)
                    Text("Welcome to").font(Font.custom("Poppins-Medium", size: 33))
                    Text("Bask").font(Font.custom("Poppins-Medium", size: 33))
                        .foregroundColor(Color(0xFF57E1D1))
                    
                }
                Spacer()
            }.padding(.horizontal, 32.0)
            Spacer()
            
            FilledButton(label: "I'm Owner", color: Color(0xFF57E1D1))
            
            FilledButton(label: "I'm guest", color: Color(0xFF161D50))
            
            
        }
    }
}

struct UserTypeSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionScreen()
    }
}
