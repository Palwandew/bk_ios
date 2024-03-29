//
//  EmptyState.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 31/07/2022.
//

import SwiftUI

struct EmptyState: View {
    
    let illustration: String
    let message: String

    var body: some View {
        HStack {
            Spacer()
            VStack{
                Spacer()
                Image(illustration)
                Text(LocalizedStringKey(message))
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .padding(.horizontal)
                Spacer()
            }
            
            Spacer()
        }
    }
}


