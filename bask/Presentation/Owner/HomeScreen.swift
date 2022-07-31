//
//  HomeScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var showAlertDialog: Bool = false
    //@StateObject var viewRouter = MaterialTabViewRouter()

    
    var body: some View {
        
        GeometryReader{ geometry in
            TabView{
                
                //MARK: - My Bookings
                
                MyBookings()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .onAppear {
                        //showAlertDialog.toggle()
                        print("onAppear() -> MyBookings")
                    }
                    .onDisappear {
                        print("onDisappear() -> MyBookings")
                    }
                
                
                //MARK: - Calendar
                
                Text("Calendar")
                    .onAppear(perform: {
                        print("onAppear() -> Calendar")
                    })
                    .onDisappear {
                        print("onDisappear() -> Calendar")
                    }
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                
                
                //MARK: - My Adds
                
                Text("My Adds")
                    .tabItem {
                        Label("My Adds", systemImage: "music.note.house.fill")
                    }
                
                
                //MARK: - Messages
                
                Text("Messages")
                    .tabItem {
                        Label("Messages", systemImage: "message.fill")
                    }
                
                
                //MARK: - Profile
                
                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .accentColor(Color(AppColor.ACCENT_GREEN))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            //MARK: - Alert Dialog
            .alertDialog(isShowing: $showAlertDialog, cornerRadius: 16.0) {
                Text("Loading")
                    .frame(width: 70, height: 70).padding()
                    
            }
        }.ignoresSafeArea(.all)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
