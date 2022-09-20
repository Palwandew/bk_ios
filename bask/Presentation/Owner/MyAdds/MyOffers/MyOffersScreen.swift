//
//  MyOffersScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct MyOffersScreen: View {
    
    private let offers: [Int] = []
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            Text("My Offers")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - Add Offer Button
            
            NavigationLink {
                ChooseOfferFacility()
            } label: {
                HStack{
                    Group {
                        Image(systemName: "plus.square.fill")
                        
                        Text("Add new offer")
                            .font(.custom("Poppins-Regular", size: 14))
                        
                        
                    }.foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(AppColor.DARKEST_BLUE)))
            }.isDetailLink(false)

//            Button{} label: {
//
//            }
//            .padding(.bottom)
            
            
            //MARK: - Offers List
            
            if offers.isEmpty {
                Spacer()
                EmptyState(illustration: "empty_my_offers_illustration", message: "You don`t have offers yet. Create your offer ad to attract guests")
                
                Spacer()
            } else {
                ScrollView{
                    LazyVStack{
                        ForEach(offers, id:\.self){ _ in
                            
                            
                            FacilityCard(price: "1600 SAR", name: "Sunny House", bookingDates: "Al Qatif", bannerText: "-400 SAR", bannerColor: Color(AppColor.LIGHT_VOILET))
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding(4)
                                .padding(.bottom, 8)
                        }
                    }
                }
            }
            
        }
        .padding(.horizontal)
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyOffersScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyOffersScreen()
    }
}
