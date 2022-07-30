//
//  MyBookings.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 29/07/2022.
//

import SwiftUI

struct MyBookings: View {
    
    @State var value: Float = 0.50
    @StateObject var viewRouter = MaterialTabViewRouter()
    
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
            
            VStack {
                
                
                //                MaterialTabView(viewRouter: viewRouter, title: "My Bookings", titleSize: 14)
                
                VStack(alignment: .leading) {
                    Text("My Bookings")
                        .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        .padding(.vertical, 8)
                        .padding(.leading)
                        
                    
                    HStack{
                        TabBarText(viewRouter: viewRouter, title: "Upcoming", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .upcoming)
                        
                        Spacer()
                        
                        TabBarText(viewRouter: viewRouter, title: "Present", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .present)
                        
                        Spacer()
                        
                        TabBarText(viewRouter: viewRouter, title: "Past", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .past)
                    }.padding(.horizontal)
                        .padding(.bottom, 4)
                        
                }.background(Color.white.shadow(radius: 4))

                
                Spacer()
                switch viewRouter.currentTab {
                case .upcoming:
                    UpcomingBookings()
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                        .onLeftSwipe {
                            withAnimation {
                                viewRouter.currentTab = .present
                            }
                        }
                    
                case .present:
                    Text("Present")
                        .transition(.opacity)
                        .onHorizontalSwipe(
                            onLeft: {
                                withAnimation {
                                    viewRouter.currentTab = .past
                                }
                            },
                            onRight: {
                                withAnimation {
                                    viewRouter.currentTab = .upcoming
                                }
                            })
                    
                case .past:
                    Text("Past")
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                        .onRightSwipe {
                            viewRouter.currentTab = .present
                        }
                }
                
                
                Spacer()
            }
            
            
            
            
        }
    }
}

struct MyBookings_Previews: PreviewProvider {
    static var previews: some View {
        MyBookings()
    }
}
