//
//  ChattingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

class VM: ObservableObject {
    @Published var count: Int = 0
    @Published var msg: [Msg] = []
    
    func add(type: Int, _ body: String ){
        
        if !body.isEmpty{
            msg.append(Msg(type: type, body: body))
            count += 1
        }
    }
}

struct ChattingScreen: View {
    @State var message: String = ""
    @State var type: Int = 0
    @State var lan: String = "en"
    @StateObject var vm = VM()
    static let fakeID: String = "fakeID"
    @State var resign: Bool = false
    @State var maxSize: Bool = false
    
    
    
    @State private var dynamicHeight: CGFloat = 400
    var body: some View {
        VStack{
            
            ChatNavigationBar(title: "Mountaina", subTitle: "Oct 1 - Oct 3 2022")
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
            
            
            ScrollView {
                
                Text("\"Mountain\" was booked for 18.03.20-20.03.20 Here you can communicate with your guest.")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                    .padding()
                    .background(Color(AppColor.CHAT_BOOKED_ITEM).cornerRadius(8))

                
                ScrollViewReader { proxy in
                    LazyVStack{
                        
                        ForEach(vm.msg) { msg in
                            if msg.type == 1 {
                                SentItem(lan: lan, text: msg.body)
                                    .padding(.bottom)
                            }
                            
                            if msg.type == 2 {
                                ReceivedItem(lan: lan)
                                    .padding(.bottom)
                            }
                        }
                        HStack{ Spacer()}
                        .id(Self.fakeID)
                        
                    }.onReceive(vm.$count) { _ in
                        withAnimation(.easeOut(duration: 0.5)) {
                            proxy.scrollTo(Self.fakeID, anchor: .bottom)
                        }
                    }
                    
                }
            }
            
            MessageInputField(text: $message) {
                vm.add(type: 1, message)
                message = ""
            }
                .padding(.horizontal)
                .padding(.bottom, 8)
            
        }.background(Color(AppColor.BACKGROUND))
            .navigationBarHidden(true)
    }
}


struct Msg: Identifiable {
    
    let id: String = UUID().uuidString
    let type: Int
    let body: String
}

struct ChattingScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChattingScreen()
        ChattingScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct ChatNavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    
    let title: String
    let subTitle: String

    
    var body: some View {
        HStack(spacing: 16){
            Image(systemName: "chevron.backward")
                .foregroundColor(.gray)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .underline()
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .lineLimit(1)
                
                HStack{
                    Image(systemName: "calendar")
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    Text(subTitle)
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
    
    let lan: String
    let text: String
    
    var body: some View {
        
        VStack(alignment: lan == "ar" ? .leading : .trailing) {
            HStack{
                
                if lan == "en" {
                    Spacer()
                }
                
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text(text)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    HStack{
                        Text("9:30 PM")
                            .font(.custom("Poppins-Regular", size: 10))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        
                        MessageDeliveryIndicator()
                    }
                }.padding(12)
                    .background(Color(AppColor.CHAT_SENT_ITEM)
                                    .roundCorners(radius: 8, [.topLeft, .bottomLeft, .bottomRight])
                                    .shadow(radius: 1))
                
                if lan == "ar" {
                    Spacer()
                }
                
            }.padding(.trailing)
            //.padding(.leading, 64)
                .onTapGesture {
                    print("locale iden: \(lan)")
                }
        }
        
    }
}

struct ReceivedItem: View {
    
    let lan: String
    
    var body: some View {
        
        VStack(alignment: lan == "ar" ? .trailing : .leading) {
            HStack{
                
                if lan == "ar"{
                    Spacer()
                }
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text("Hello how are you? What are you up to these days are you doing good? Hah wat wr")
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Text("9:30 PM")
                        .font(.custom("Poppins-Regular", size: 10))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    
                }.padding(12)
                    .background(Color.white.roundCorners(radius: 8, [.topRight, .bottomLeft, .bottomRight]).shadow(radius: 1))
                
                if lan == "en"{
                    Spacer()
                }
                
            }.padding(.leading)
            //.padding(.trailing, 64)
                .onTapGesture {
                }
        }
        
    }
    
}
