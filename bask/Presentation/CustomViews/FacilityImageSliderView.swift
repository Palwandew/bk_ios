//
//  FacilityImageSliderView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/09/2022.
//

import SwiftUI

struct FacilityImageSliderView: View {
    @State private var currentIndex = 0
    private let colors: [Color] = [.red, .blue]
      
      // MARK: - Body
      
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentIndex.animation()) { // 1
              ForEach(0..<colors.count, id: \.self) { index in
                colors[index]
                  .tag(index)
              }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack(spacing: -48) {
                
                Spacer()
                
                ImageIndexIndicatorView(numberOfPages: colors.count, currentIndex: currentIndex)
                    
                Spacer()
                
                Text("\(currentIndex + 1) / \(colors.count)")
                    .font(.custom("Poppins-Regular", size: 12, relativeTo: .body))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .padding(.trailing)
                
            }.padding(.bottom, 48)
        }
    }
}

struct FacilityImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityImageSliderView()
    }
}


struct ImageIndexIndicatorView: View {
  
  // MARK: - Public Properties
  
  let numberOfPages: Int
  let currentIndex: Int
  
  
  // MARK: - Drawing Constants
  
  private let circleSize: CGFloat = 16
  private let circleSpacing: CGFloat = 12
  
    private let primaryColor = Color(AppColor.ACCENT_GREEN)
  private let secondaryColor = Color.white.opacity(0.6)
  
  private let smallScale: CGFloat = 0.6
  
  
  // MARK: - Body
  
  var body: some View {
    HStack(spacing: circleSpacing) {
      ForEach(0..<numberOfPages) { index in // 1
        if shouldShowIndex(index) {
          Circle()
            .fill(currentIndex == index ? primaryColor : secondaryColor) // 2
            .scaleEffect(currentIndex == index ? 1 : smallScale)
            
            .frame(width: circleSize, height: circleSize)
       
            .transition(AnyTransition.opacity.combined(with: .scale)) // 3
            
            .id(index) // 4
        }
      }
    }
  }
  
  
  // MARK: - Private Methods
  
  func shouldShowIndex(_ index: Int) -> Bool {
    ((currentIndex - 1)...(currentIndex + 1)).contains(index)
  }
}

