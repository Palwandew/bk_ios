//
//  HomeScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewRouter = MaterialTabViewRouter()
    var body: some View {
        TabView{
            
            MyBookings()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
            Text("Calendar")
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            Text("My Adds")
                .tabItem {
                    Label("My Adds", systemImage: "music.note.house.fill")
                }
            
            Text("Messages")
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            
        }.accentColor(Color(AppColor.ACCENT_GREEN))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
