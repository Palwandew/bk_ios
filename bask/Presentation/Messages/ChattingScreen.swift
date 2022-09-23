//
//  ChattingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct ChattingScreen: View {
    @State var message: String = ""
    var body: some View {
        VStack{
            
            ChatTitle()
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
            
            ScrollView {
                LazyVStack{
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                    
                    ReceivedItem()
                        .padding(.trailing, 64)
                        .padding(.bottom)
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                    
                    ReceivedItem()
                        .padding(.trailing, 64)
                        .padding(.bottom)
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                    
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                    
                    ReceivedItem()
                        .padding(.trailing, 64)
                        .padding(.bottom)
                    
                    SentItem()
                        .padding(.leading, 64)
                        .padding(.bottom)
                }
                
            }
            
            CommentField(comment: $message)
                .frame(width: 320, height: 15)
                .padding(.horizontal)
        }.background(Color(AppColor.BACKGROUND))
            .navigationBarHidden(true)
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

struct SentItem: View {
    var body: some View {
        HStack{
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("Hello how are you?")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                HStack{
                    Text("9:30 PM")
                        .font(.custom("Poppins-Regular", size: 10))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(AppColor.ACCENT_GREEN))
                }
            }.padding(12)
                .background(Color(AppColor.CHAT_SENT_ITEM).roundCorners(radius: 8, [.topLeft, .bottomLeft, .bottomRight]).shadow(radius: 1))
            
        }.padding(.trailing)
    }
}

struct ReceivedItem: View {
    var body: some View {
        HStack{
            
            
            
            VStack(alignment: .trailing, spacing: 8) {
                Text("Hello how are you? What are you up to these days are you doing good? Hah wat wr")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                    Text("9:30 PM")
                        .font(.custom("Poppins-Regular", size: 10))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                
            }.padding(12)
                .background(Color.white.roundCorners(radius: 8, [.topRight, .bottomLeft, .bottomRight]).shadow(radius: 1))
            
            Spacer()
        }.padding(.leading)
    }
}
