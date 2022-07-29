//
//  MaterialTabView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 30/07/2022.
//

import SwiftUI

struct MaterialTabView: View {
    
    @StateObject var viewRouter: MaterialTabViewRouter
    
    @State var upComing: Bool = true
    @State var present: Bool = false
    @State var past: Bool = false
    
    var body: some View {
        GeometryReader { geomerty in
            VStack {
                HStack{
                    TabBarText(isSelected: $upComing, viewRouter: viewRouter, title: "Upcoming", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .upcoming)
                    
                    Spacer()
                    
                    TabBarText(isSelected: $present, viewRouter: viewRouter, title: "Present", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .present)
                    
                    Spacer()
                    
                    TabBarText(isSelected: $past, viewRouter: viewRouter, title: "Past", width: geomerty.size.width/5, height: geomerty.size.height/150, assignedTab: .past)
                }
                .padding(.horizontal)
                .frame(width: geomerty.size.width, height: geomerty.size.height/12)
                .background(Color(AppColor.GREY).shadow(radius: 2))
                
                Spacer()
                switch viewRouter.currentTab {
                case .upcoming:
                    Text("Upcoming")
                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .leading)))
                        .onLeftSwipe {
                            withAnimation {
                                viewRouter.currentTab = .present
                            }
                        }
                    
                case .present:
                    Text("Present")
                        .transition(.opacity)
                        .onHorizontalSwipe(onLeft: {
                            withAnimation {
                                viewRouter.currentTab = .past
                            }
                        }, onRight: {
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

struct MaterialTabView_Previews: PreviewProvider {
    static var previews: some View {
        MaterialTabView(viewRouter: MaterialTabViewRouter())
    }
}

struct TabBarText: View {
    
    @Binding var isSelected: Bool
    @StateObject var viewRouter: MaterialTabViewRouter
    let title: String
    let width, height: CGFloat
    let assignedTab: MaterialTabViewPage
    private let appGreen: Color = Color(AppColor.ACCENT_GREEN)
    
    var body: some View {
        VStack{
            Text(title)
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                .foregroundColor(viewRouter.currentTab == assignedTab ? Color(AppColor.DARKEST_BLUE) : Color(AppColor.MAIN_TEXT_LIGHT))
            
            Rectangle().fill( viewRouter.currentTab == assignedTab ? appGreen : .clear)
                .frame(width: width, height: height)
                .transition(.offset(x: 5, y: 0))
            
        }.onTapGesture {
            viewRouter.currentTab = assignedTab
        }
    }
}
