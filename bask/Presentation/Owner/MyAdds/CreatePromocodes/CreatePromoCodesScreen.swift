//
//  CreatePromoCodesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct CreatePromoCodesScreen: View {
    
    @State var selectedIndex: Int = 0
    
    
    var body: some View {
        VStack(alignment: .leading) {
            //MARK: - Title
            Header(selectedIndex: selectedIndex)
            
            
            TabView(selection: $selectedIndex.animation()) {
                
                NewPromoCodeScreen()
                    .tag(0)
                
                ExistingCodesScreen()
                    .tag(1)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
        
    }
}


struct CreatePromoCodesScreen_Preview: PreviewProvider {
    static var previews: some View {
        
        CreatePromoCodesScreen()
        
        CreatePromoCodesScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
    }
    
    
}

struct Header: View {
    let selectedIndex: Int
    private let width: CGFloat = UIScreen.main.bounds.width
    @State private var initialOffSet: CGFloat = UIScreen.main.bounds.width / 8
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Create promocode")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            
            HStack{
                Group {
                    Text("New promocode")
                        .foregroundColor(selectedIndex == 0 ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    Spacer()
                    
                    Text("Existing codes")
                        .foregroundColor(selectedIndex == 1 ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
                    
                }.font(.custom("Poppins-Regular", size: 16))
            }
            .padding(.top, 8)
            .padding(.bottom, 4)
            .padding(.horizontal)
            
            HStack{
                RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.ACCENT_GREEN))
                    .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height * 0.01)
                    .offset(x: selectedIndex == 0 ? initialOffSet : (width - (width * 0.30)))
                    .animation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0), value: selectedIndex)
                
            }
            .padding(.horizontal)
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
        }
        .background(Color.white)
    }
}
