//
//  ExistingCodesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/09/2022.
//

import SwiftUI

struct ExistingCodesScreen: View {
    
    @State private var promoCodes: [Int] = []
    @State private var state: ScreenState = .failed
    
    var body: some View {
        
        switch state {
        case .loading:
            Spinner()
        case .success:
            VStack {
                if !promoCodes.isEmpty {
                    ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        PromoTicket()
                        
                        PromoTicket()
                        
                        PromoTicket()
                        
                        PromoTicket()
                        
                        PromoTicket()

                    }.padding(.top)
                    }
                } else {
                    EmptyState(illustration: "empty_existing_promo", message: "empty_promo_message")
                }
            }
        case .failed:
            ErrorStateScreen()
        case .initial:
            EmptyView()
        }

        
    }
}

struct ExistingCodesScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExistingCodesScreen()
    }
}

struct PromoTicket: View {
    
    private let colors: [Color] = [Color(AppColor.ACCENT_GREEN), Color(AppColor.LIGHT_VOILET), Color(AppColor.DARK_BLUE), Color(AppColor.DARKEST_BLUE), Color(AppColor.GREY), Color(AppColor.YELLOW), Color(AppColor.MAIN_TEXT_DARK)]
    
    
    var body: some View{
            VStack(spacing: 0) {
                
                
                HStack(alignment: .top, spacing: 24){
                        
                        Spacer()
                        Text("15 %")
                            .font(.custom("Poppins-Regular", size: 26))
                    
                        
                        VStack(alignment: .leading){
                            Text("SUPER 15")
                                .font(.custom("Poppins-Regular", size: 16))
                            
                            Text("Validity: 20 Sep, 2022")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        Spacer()
                        
                    }
                    .padding()
                    .padding(.vertical, 8)
                    .background(ExistingPromoTicketUpperPartShape().fill(.white).cornerRadius(8).shadow(radius: 4).padding(.horizontal))
                
                HStack {
                    
                    Group {
                        Spacer()
                        
                        Text("SUPPER 15")
                            .font(.custom("Poppins-Regular", size: 16))
                        .padding(.leading, 24)
                        
                        Spacer()
                        
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait.fill")
                            .padding(.trailing)
                    }.foregroundColor(.white)
                    
                }
                .padding()
                .background(ExistingPromoTicketLowerPartShape()
                    .fill(colors.randomElement() ?? Color(AppColor.LIGHT_VOILET)).cornerRadius(8).shadow(radius: 4).padding(.horizontal))
              
        }
    }
}
