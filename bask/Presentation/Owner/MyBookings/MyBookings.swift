//
//  MyBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct MyBookings: View {
    
    @State private var value: Float = 0.50
    @State private var currentSelection: Int = 0
    @StateObject private var viewRouter = MaterialTabViewRouter()
    @StateObject private var myBookingsViewModel = MyBookingsViewModel(BookingRepositoryImpl(httpClient: HttpClient()))
    @State private var showAlertDialog: Bool = false
    
    
    var body: some View {
        VStack(spacing:0){
            
            
            ZStack{
                
                Image("home_illustration")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
                
                
                RentCollectionIndicator(collectionStatus: $value)
                    .frame(height: UIScreen.main.bounds.height * 0.15)
                    .padding(.horizontal)
            }
            
                
                VStack(alignment: .leading) {
                    Text("My Bookings")
                        .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        .padding(.vertical, 8)
                        .padding(.leading)
                        
                    
                    HStack{
                        TabBarText(viewRouter: viewRouter, title: "Upcoming", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .one)
                        
                        Spacer()
                        
                        TabBarText(viewRouter: viewRouter, title: "Present", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .two)
                        
                        Spacer()
                        
                        TabBarText(viewRouter: viewRouter, title: "Past", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .three)
                    }.padding(.horizontal)
                        .padding(.bottom, 4)
                        
                }.background(Color.white.shadow(radius: 4))

                
                Spacer()
                
                TabView(selection: $currentSelection) {
                    UpcomingBookingsView()
                        .tag(0)
                    
                    PresentBookingsView()
                        .tag(1)
                    
                    PastBookingsView()
                        .tag(2)
                    
                }
                .environmentObject(myBookingsViewModel)
                .tabViewStyle(.page)
                    .onChange(of: currentSelection) { newValue in
                        self.handleTabChange(newValue)
                    }
                Spacer()
            
        }.background(Color.white)
    }
    
    private func handleTabChange(_ newValue: Int){
        if newValue == 0 {
            viewRouter.currentTab = .one
        }
        if newValue == 1 {
            viewRouter.currentTab = .two
        }
        if newValue == 2 {
            viewRouter.currentTab = .three
        }
    }
}

struct MyBookings_Previews: PreviewProvider {
    static var previews: some View {
        MyBookings()
    }
}
