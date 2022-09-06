//
//  MyUnitsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct MyUnitsScreen: View {
    
    @StateObject var viewRouter = MaterialTabViewRouter()
    @StateObject var viewModel = MyUnitsViewModel()
    
    var body: some View {

        VStack {
            
            VStack(alignment: .leading) {
                Text("My Units")
                    .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .body))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.vertical, 8)
                    .padding(.leading)
                    
                
                HStack{
                    TabBarText(viewRouter: viewRouter, title: "Booked", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .one)
                    
                    Spacer()
                    
                    TabBarText(viewRouter: viewRouter, title: "Available", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .two)
                    
                    Spacer()
                    
                    TabBarText(viewRouter: viewRouter, title: "Unpublished", width: UIScreen.main.bounds.width / 5, height: 3, assignedTab: .three)
                }.padding(.horizontal)
                    .padding(.bottom, 4)
                    .background(Color.white.shadow(radius: 3, y: 5))

                    
            }
            
            Spacer()
            switch viewRouter.currentTab {
            case .one:

                BookedFacilitiesScreen()
                    .environmentObject(viewModel)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                    .onLeftSwipe {
                        withAnimation {
                            viewRouter.currentTab = .two
                        }
                    }
                    .onAppear {
                        print("onAppear() -> Upcoming bookings")
//                            myBookingsViewModel.screenState = .loading
                        viewModel.updateState()
                    }
                    .onDisappear {
                        print("onDisappear() -> Upcoming bookings")
                        //myBookingsViewModel.screenState = .loading
                    }
                    
                
            case .two:
                AvailableFacilitiesScreen()
                    .environmentObject(viewModel)
                    .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                    .onHorizontalSwipe(
                        onLeft: {
                            withAnimation {
                                viewRouter.currentTab = .three
                            }
                        },
                        onRight: {
                            withAnimation {
                                viewRouter.currentTab = .one
                            }
                        })
                    .onAppear {
                        print("onAppear() -> Present bookings")
                        viewModel.updateState()
                    }
                    .onDisappear {
                        print("onDisappear() -> Present bookings")
                        //myBookingsViewModel.screenState = .loading
                    }
                
            case .three:
                UnpublishedFacilitiesScreen()
                    .environmentObject(viewModel)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                    .onRightSwipe {
                        withAnimation {
                            viewRouter.currentTab = .two
                        }

                    }
                    .onAppear {
                        print("onAppear() -> Past bookings")
                        //myBookingsViewModel.updateState()
                        //viewModel.screenState = .loading
                        //viewModel.updateState()
                    }
                    .onDisappear {
                        print("onDisappear() -> Past bookings")
                        //myBookingsViewModel.screenState = .loading
                    }
            }
            
            
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct MyUnitsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyUnitsScreen()
    }
}
