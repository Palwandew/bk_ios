//
//  MyGuestsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 14/09/2022.
//

import SwiftUI

struct MyGuestsScreen: View {
    
    @State var selectedItem = 0
    @State var shallAnimate: Bool = false
    @State var dashSize: CGSize = .zero
    
    @State var model = UpcomingGuestsViewModel(repository: GuestsRepositoryImpl())
    @State var pgViewModel = PresentGuestsViewModel(repository: GuestsRepositoryImpl())
    @State var ratingViewModel = RatingGuestsViewModel(repository: GuestsRepositoryImpl())
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("My Guests", comment: "Screen Title")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding([.leading, .bottom])
            
            ExtractedView(index: $selectedItem, size: $dashSize)
                .frame(height: 30)
            
            Rectangle().fill(Color(AppColor.ACCENT_GREEN))
                .frame(width: dashSize.width, height: 5)
            
                .offset(x: shallAnimate ? (dashSize.height) - (dashSize.width / 2) : 0 )
            
                .animation(.interpolatingSpring(mass: 1.0,stiffness: 100.0,damping: 10,initialVelocity: 0), value: dashSize.height)
                .onChange(of: selectedItem) { newValue in
                    shallAnimate = true
  
                }
            
            
            
            TabView(selection: $selectedItem){
                
                UpcomingGuestsScreen()
                    .environmentObject(model)
                    .tag(0)
                
                PresentGuestsScreen()
                    .environmentObject(pgViewModel)
                    .tag(1)
                
                RatingScreen()
                    .environmentObject(ratingViewModel)
                    .tag(2)
                
            }.tabViewStyle(.page(indexDisplayMode: .never))
                .background(Color(AppColor.BACKGROUND))
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct MyGuestsScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyGuestsScreen()
        
        MyGuestsScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
        
    }
}

struct ExtractedView: View {
    
    @Binding var index: Int
    @Binding var size: CGSize
    @State private var first: CGSize = .zero
    @State private var second: CGSize = .zero
    @State private var third: CGSize = .zero
    
    var body: some View {
        
        
        GeometryReader { geometry in
            
            HStack{
                Text("Upcoming")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .background(
                        GeometryReader { reader in
                            
                            Color.clear
                                .preference(key: SizePreferenceKey.self, value: CGSize(width: reader.size.width, height: reader.frame(in: .global).midX))
                        }
                    ).onPreferenceChange(SizePreferenceKey.self) { newSize in
                        self.first = newSize
                        size = newSize
                        print("firs")
                        print("Global : \(Int(geometry.frame(in: .global).midX)), \(Int(geometry.frame(in: .global).midY)) ")
                    }
                
                
                Spacer()
                
                
                Text("Present")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .background(
                        GeometryReader { reader in
                            Color.clear
                                .preference(key: SizePreferenceKey.self, value: CGSize(width: reader.size.width, height: reader.frame(in: .global).midX))
                            
                        }
                    ).onPreferenceChange(SizePreferenceKey.self) { newSize in
                        self.second = newSize
                        
                       
                        
                    }
                
                
                Spacer()
                
                Text("Rating")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .background(
                        GeometryReader { reader in
                            Color.clear
                                .preference(key: SizePreferenceKey.self, value: CGSize(width: reader.size.width, height: reader.frame(in: .global).midX))
                        }
                    ).onPreferenceChange(SizePreferenceKey.self) { newSize in
                        self.third = newSize
                        print("Thir")
                        print("Global : \(Int(geometry.frame(in: .local).midX)), \(Int(geometry.frame(in: .local).midY)) ")
                    }
            }
            
            
            
            
            
            
        }
        .padding(.horizontal)
        .onChange(of: index) { newValue in
            if newValue == 0 {
                size = first
            }
            if newValue == 1 {
                size = second
            }
            if newValue == 2 {
                size = third
            }
        }
        
    }
    
    func setSize(newSize: CGSize) {
        self.size = newSize
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct PositionPrefKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}
