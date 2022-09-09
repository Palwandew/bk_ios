//
//  FacilityImageSliderView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/09/2022.
//

import SwiftUI

//MARK: - FacilityImagesSliderView
struct FacilityImagesSliderView: View {
    
    @Binding var isPopupShown: Bool
    @Binding var cancelBookingDialog: Bool
    let popupStyle: FacilityDetailsStyle
    let onBackTapped: () -> Void
    let onPopupTapped: () -> Void
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                
                ImageSliderView()
                
                VStack(spacing: -8) {
                    HStack {
                        FadedBlueButton(icon: "chevron.left") {
                            
                            onBackTapped()
                            
                            
                        }.frame(width: 42, height: 42)
                        
                        Spacer()
                        
                        FadedBlueButton(icon: "ellipsis") {
                            
                            withAnimation {
                                onPopupTapped()
                            }
                            
                        }.frame(width: 42, height: 42)
                    }.padding()
                    
                    if isPopupShown{
                        PopupView(style: popupStyle, onButtonTapped: { button in
                            switch button {
                            case .cancel:
                                print("Cancel")
                                cancelBookingDialog.toggle()
                                isPopupShown.toggle()
                            case .edit:
                                print("edit")
                                isPopupShown.toggle()
                            case .unpublish:
                                print("Unpub")
                                isPopupShown.toggle()
                            }
                        })
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                    }
                    
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.340)
            
            Spacer()
        }
    }
}

struct ImageSliderView: View {
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



//MARK: PopupView
struct PopupView: View {
    
    let style: FacilityDetailsStyle
    fileprivate let onButtonTapped: (PopupButton) -> Void
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .leading) {
                
                if style == .booked {
                    Button {
                        withAnimation {
                            onButtonTapped(.cancel)
                        }
                        
                    } label: {
                        Text("Cancel booking")
                            .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            .padding(.top, 4)
                    }
                }
                
                
                Button {
                    withAnimation {
                        onButtonTapped(.edit)
                    }
                } label: {
                    Text("Edit Description")
                        .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(.top, 4)
                }
                
                Button {
                    withAnimation {
                        onButtonTapped(.unpublish)
                    }
                } label: {
                    Text("Unpublish Item")
                        .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(8)
        }.padding(.trailing)
    }
}


//MARK: - PopupButton
fileprivate enum PopupButton{
    case cancel
    case edit
    case unpublish
}
