//
//  MaterialTabView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct MaterialTabView: View {
    
    @StateObject var viewRouter: MaterialTabViewRouter
    
    let title: String
    let titleSize: CGFloat
    var titleStyle: Font.TextStyle = .body
    
    
    var body: some View {
        GeometryReader { geomerty in
//            VStack {
                
                VStack(alignment: .leading) {
                    
                    Text(title)
                        .font(Font.custom("Poppins-Medium", size: titleSize, relativeTo: titleStyle))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        .padding([.top, .leading])
                    
                    
                    HStack{
                        TabBarText(viewRouter: viewRouter, title: "Upcoming", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .one)
                        
                        Spacer()
                        
                        TabBarText( viewRouter: viewRouter, title: "Present", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .two)
                        
                        Spacer()
                        
                        TabBarText( viewRouter: viewRouter, title: "Past", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .three)
                    }
                    .padding(.horizontal)
                    .frame(width: geomerty.size.width, height: geomerty.size.height/8)
                }.background(Color.white.shadow(radius: 2))

                

                
//                Spacer()
//                switch viewRouter.currentTab {
//                case .upcoming:
//                    Text("Upcoming")
//                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
//                        .onLeftSwipe {
//                            withAnimation {
//                                viewRouter.currentTab = .present
//                            }
//                        }
//                    
//                case .present:
//                    Text("Present")
//                        .transition(.opacity)
//                        .onHorizontalSwipe(
//                            onLeft: {
//                                withAnimation {
//                                    viewRouter.currentTab = .past
//                                }
//                            },
//                            onRight: {
//                                withAnimation {
//                                    viewRouter.currentTab = .upcoming
//                                }
//                            })
//                    
//                case .past:
//                    Text("Past")
//                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
//                        .onRightSwipe {
//                            viewRouter.currentTab = .present
//                        }
//                }
//                Spacer()
                
                
            
        }
    }
}



struct TabBarText: View {
    
    @StateObject var viewRouter: MaterialTabViewRouter
    let title: String
    let width, height: CGFloat
    let assignedTab: MaterialTabViewPage
    private let appGreen: Color = Color(AppColor.ACCENT_GREEN)
    
    var body: some View {
        VStack{
            Text(LocalizedStringKey(title))
                .font(Font.custom("Poppins-Regular", size: 16, relativeTo: .body))
                .foregroundColor(viewRouter.currentTab == assignedTab ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
            
            Rectangle().fill( viewRouter.currentTab == assignedTab ? appGreen : .clear)
                .frame(width: width, height: height)
                .transition(.offset(x: 5, y: 0))
            
        }
    }
}
