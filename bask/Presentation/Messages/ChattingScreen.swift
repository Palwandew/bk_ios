//
//  ChattingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct ChattingScreen: View {
    var body: some View {
        VStack{
            
            ChatTitle()
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
            
            Spacer()
        }.background(Color(AppColor.BACKGROUND))
    }
}

struct ChattingScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChattingScreen()
    }
}

struct ChatTitle: View {
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: "chevron.backward")
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Heelo how are you")
                    .underline()
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .lineLimit(1)
                
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    Text("Sep 20 - Sep 25 2022")
                        .font(.custom("Poppins-Regular", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                }
            }.padding(.vertical, 8)
            
            Spacer()
            
            Image(systemName: "ellipsis")
                .rotationEffect(.degrees(90))
                .foregroundColor(.gray)
        }.padding(.horizontal)
            .background(Color.white)
    }
}
