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
    @ObservedObject var myBookingsViewModel = MyBookingsViewModel()
    @State var showAlertDialog: Bool = false
    
    
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
                        .environmentObject(myBookingsViewModel)
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                        .onLeftSwipe {
                            withAnimation {
                                viewRouter.currentTab = .present
                            }
                        }
                        .onAppear {
                            print("onAppear() -> Upcoming bookings")
//                            myBookingsViewModel.screenState = .loading
                            myBookingsViewModel.updateState()
                        }
                        .onDisappear {
                            print("onDisappear() -> Upcoming bookings")
                            //myBookingsViewModel.screenState = .loading
                        }
                        
                    
                case .present:
                    PresentBookings()
                        .environmentObject(myBookingsViewModel)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
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
                        .onAppear {
                            print("onAppear() -> Present bookings")
                            myBookingsViewModel.updateState()
                        }
                        .onDisappear {
                            print("onDisappear() -> Present bookings")
                            //myBookingsViewModel.screenState = .loading
                        }
                    
                case .past:
                    PastBookings()
                        .environmentObject(myBookingsViewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                        .onRightSwipe {
                            withAnimation {
                                viewRouter.currentTab = .present
                            }

                        }
                        .onAppear {
                            print("onAppear() -> Past bookings")
                            //myBookingsViewModel.updateState()
                            myBookingsViewModel.screenState = .loading
                            myBookingsViewModel.updateState()
                        }
                        .onDisappear {
                            print("onDisappear() -> Past bookings")
                            //myBookingsViewModel.screenState = .loading
                        }
                }
                
                
                Spacer()
            }
            
            
            
            
        }.background(Color.white)
        
    }
}

struct MyBookings_Previews: PreviewProvider {
    static var previews: some View {
        MyBookings()
    }
}