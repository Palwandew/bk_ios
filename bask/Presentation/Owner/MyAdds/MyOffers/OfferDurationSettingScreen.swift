//
//  OfferDurationSettingScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct OfferDurationSettingScreen: View {
    
    
    @EnvironmentObject var model: NewOfferViewModel
    @State var show: Bool = false
    @State var text: String = DateFormatter.test.string(from: Date())
    
    @State var startDate: Date? = Date()
    @State var endDate: Date? = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            //MARK: - Offer duration
            Text("Duration of offer")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            
            //MARK: - Offer duration input
            HStack {
                MaterialDropdown(menuShowed: $show, selectedText: model.offer.formattedStartDate, icon: "calendar") {
                    showCalendar()
                }
                

                Text("to")
                    .font(.custom("Poppins-Regular", size: 16))
                
                MaterialDropdown(menuShowed: $show, selectedText: model.offer.formattedEndDate, icon: "calendar") {
                    showCalendar()
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.07)
                .padding(.horizontal)
                
            Spacer()
            
        }
        
        .sheet(isPresented: $show, content: {
            //CalendarViews(startDate: $startDate, endDate: $endDate)
                //.padding(.top)
        })
        
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func showCalendar() {
        show.toggle()
    }
}

struct OfferDurationSettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OfferDurationSettingScreen()
        
        OfferDurationSettingScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
        
        
    }
}
