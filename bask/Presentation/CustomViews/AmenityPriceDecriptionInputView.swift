//
//  AmenityPaidCounter.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct AmenityPriceDecriptionInputView: View {
    
    @Binding var text: String
    @Binding var isValid: Bool
    @Binding var description: String
    @State var menuShowed: Bool = false
    @State var selectedText: String = "day"
    @State private var validDescription: Bool = true
    let errorMessage: LocalizedStringKey = "valid_description"
    let type: AmenityDetail = .description
    let menuItem: [String] = ["day", "item"]
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            VStack{
                
                HStack {
                    MaterialPriceField(text: $text, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Price")
                    
                    Text("per")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    MaterialDropdown(menuShowed: $menuShowed, selectedText: $selectedText) {
                        print("hee")
                        menuShowed.toggle()
                    }.frame(height: 57)
                }
                
                MaterialTextField(text: $description, isValid: $validDescription, errorMessage: errorMessage, placeHolder: "Description (Optional)")
            }
            
            VStack{
                if menuShowed {
                    
                    VStack(spacing: 16) {
                        ForEach(menuItem.indices, id:\.self) { index in
                            
                            if selectedText != menuItem[index]{
                                HStack {
                                    Text(menuItem[index])
                                        .font(Font.custom("Poppins-Regular", size: 16))
                                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                    
                                    Spacer()
                                    
                                }.contentShape(Rectangle())
                                    .onTapGesture {
                                        
                                        
                                        selectedText = menuItem[index]
                                        withAnimation{
                                            menuShowed.toggle()
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.40)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white).shadow(radius: 3))
                    .transition(.opacity)
                }
            }
            
            .offset(x: 0, y: 25)
        }.padding(.horizontal, 1)
    }
}

enum AmenityDetail {
    case description
    case area
}

//struct AmenityPaidCounter_Previews: PreviewProvider {
//    static var previews: some View {
//        AmenityPriceDecriptionInputView()
//    }
//}


struct MaterialDropdown: View {
    
    private let color: Color = Color(red: 0.404, green: 0.424, blue: 0.561)
    
    @Binding var menuShowed: Bool
    @Binding var selectedText: String
    let onTapped: () -> Void
    
    var body: some View {
        
        GeometryReader { geomerty in
            ZStack() {
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(menuShowed ? Color(AppColor.LIGHT_VOILET) : Color(AppColor.GREY), lineWidth: menuShowed ? 2 : 1)
                
                HStack{
                    
                    Text(selectedText)
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Spacer()
                    
                    Image(systemName: menuShowed ? "chevron.up" : "chevron.down")
                        .foregroundColor(color)
                    
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
                .onTapGesture {
                    onTapped()
                }
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
        }
    }
}
