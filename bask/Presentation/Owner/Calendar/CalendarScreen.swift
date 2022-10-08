//
//  CalendarScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/10/2022.
//

import SwiftUI

struct CalendarScreen: View {
    
    @State var selectedIndex: Int = 0
    @State var startDate: Date? = nil
    @State var endDate: Date? = nil
    
    @State var price: String = ""
    @State var isValid: Bool = true
    let error: LocalizedStringKey = LocalizedStringKey("error")
    
    @State var menuShowed: Bool = false
    
    @State var selectedMenuItem: String = "unavailable"
    private var menuItem: [String] = ["available", "booked", "unavailable"]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Title
            CalendarFacilities(selectedIndex: selectedIndex)
            
            Group{
                
                
                
                HStack(alignment: .top){
                    
                    Image(systemName: "calendar")
                    
                    Text("Al Qatif 32641, Saudi Arabia")
                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .lineLimit(2)
                    
                }
                
                HStack(alignment: .top){
                    
                    Image(systemName: "calendar")
                    
                    Text("Default price is 800 SAR per night")
                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .lineLimit(2)
                    
                }.padding(.vertical, 4)
                
                if startDate == nil {
                    HStack {
                        Spacer()
                        Text("Select dates to change status or price")
                            .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            .padding()
                            
                        Spacer()
                    }.background(Color(AppColor.LIGHT_GREY).cornerRadius(8))
                    
                    
                } else {
                    HStack{
                        
                        MaterialPriceField(text: $price, isValid: $isValid, errorMessage: error, placeHolder: "Price per night")
                        
                        MaterialDropdown(menuShowed: $menuShowed, selectedText: selectedMenuItem) {
                            withAnimation {
                                menuShowed.toggle()
                            }

                        }.frame(height: 55)
                        
                    }
                }
                
                
            }.padding(.horizontal)
            
            ZStack(alignment: .topTrailing) {
                
                CalendarViews(startDate: $startDate, endDate: $endDate)
                
                if menuShowed {
                    VStack(alignment: .leading, spacing: 16){
                        
                        ForEach(menuItem, id:\.self) { menuItem in
                            
                            if !menuItem.elementsEqual(selectedMenuItem){
                                HStack {
                                    Text(menuItem)
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                        .padding(.leading)

                                    Spacer()
                                }.contentShape(Rectangle())
                                .onTapGesture {
                                        selectedMenuItem = menuItem
                                        menuShowed.toggle()
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2.25)
                    .padding(.vertical)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.white).shadow(radius: 2))
                    .padding(.trailing)
                    .transition(.scale)
                    
                }
                
                    
            }
            
            
//            TabView(selection: $selectedIndex.animation()) {
//
//                Text("First")
//                    .tag(0)
//
//                Text("second")
//                    .tag(1)
//            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
    }
}


struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}


struct CalendarFacilities: View {
    let selectedIndex: Int
    let tabHeader: [String] = ["Mountaina Resort", "Second", "Third Resort"]
    private let width: CGFloat = UIScreen.main.bounds.width
    @State private var initialOffSet: CGFloat = UIScreen.main.bounds.width / 8
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Calendar")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                        ForEach(tabHeader, id:\.self) { tab in
                            Text(tab)
                                .foregroundColor(selectedIndex == 0 ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
                                .font(.custom("Poppins-Regular", size: 16))
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .padding(.horizontal)
                }
            }
            
            
//            HStack{
//                RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.ACCENT_GREEN))
//                    .frame(width: UIScreen.main.bounds.width * 0.10, height: UIScreen.main.bounds.height * 0.01)
//                    .offset(x: selectedIndex == 0 ? initialOffSet : (width - (width * 0.30)))
//                    .animation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0), value: selectedIndex)
//
//            }
//            .padding(.horizontal)
            
            LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 1)], startPoint: .bottom, endPoint: .top)
                .frame(height: 6)
                .opacity(0.8)
        }
        .background(Color.white)
    }
}
