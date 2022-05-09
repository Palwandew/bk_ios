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
                        .foregroundColor(Color(AppColor.DARK_BLUE))
                    Text("Bask").font(Font.custom("Poppins-Medium", size: 33))
                        .foregroundColor(Color(AppColor.ACCENT_GREEN))
                    
                }
                Spacer()
            }.padding(.horizontal, 32.0)
            Spacer()
            
            OutlinedButton(label: "I'm Owner", color: Color(AppColor.DARK_BLUE), action: {
                print("Hello Owner")
            })
            
            FilledButton(label: "I'm guest", color: Color(AppColor.DARKEST_BLUE), action: {
                print("Hello Guest")
            })
            
            
        }.background(Color(AppColor.BACKGROUND))
    }
}

struct UserTypeSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeSelectionScreen()
    }
}
