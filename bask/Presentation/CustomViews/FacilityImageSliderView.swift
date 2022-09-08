//
//  FacilityImageSliderView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/09/2022.
//

import SwiftUI

struct FacilityImageSliderView: View {
    @State private var currentIndex = 0
    private let colors: [Color] = [.red, .blue, .green, .orange, .yellow, .red, .blue, .green, .orange, .yellow, .red, .blue, .green, .orange, .yellow, .green]
      
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
            ImageIndexIndicatorView(numberOfPages: colors.count, currentIndex: currentIndex)
                .padding(.bottom)
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

