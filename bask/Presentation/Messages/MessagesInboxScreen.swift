//
//  MessagesInboxScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct MessagesInboxScreen: View {
    @State var willShowChatScreen: Bool = false
    var body: some View {

        VStack(alignment: .leading) {
            
            Text("Messages")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
                
            NavigationLink(isActive: $willShowChatScreen) {
                ChattingScreen()
            } label: {
                EmptyView()
            }

            ScrollView{
                LazyVStack(spacing: 16){
                    ForEach(0...2, id:\.self){ _ in
                        InboxItem()
                            .onTapGesture {
                                willShowChatScreen.toggle()
                            }
                    }
                }.padding(.top, 4)
            }
        }.background(Color(AppColor.BACKGROUND))
    }
}

struct MessagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        MessagesInboxScreen()
    }
}

struct InboxItem: View {
    var body: some View {
        HStack(alignment: .top, spacing: 16){
            Rectangle().fill(.black.opacity(0.1)).frame(width: 60, height: 60)
                .clipShape(Circle())
            
            
            VStack(alignment: .leading, spacing: 8){
                Text("Palwandew")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .fontWeight(.bold)
                
                Text("Hi, what are you up to this morning")
                    .font(.custom("Poppins-Regular", size: 14))
                    .fontWeight(.semibold)
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
                
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                Text("13:02")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                Text("20")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Circle().fill(Color(AppColor.LIGHT_VOILET)))
                
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(radius: 4))
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
    }
}
