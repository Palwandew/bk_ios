//
//  ChooseOfferFacility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct ChooseOfferFacility: View {
    
    @State var units: [Int] = [1]
    @State var willShowOfferPriceSetting: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            Text("Choose facility for offer")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.horizontal)
            
            Text("Choose unit for offer from existing ads")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.horizontal)
                .padding(.bottom)
            
            NavigationLink(isActive: $willShowOfferPriceSetting) {
                OfferPriceSettingScreen()
            } label: {
                EmptyView()
            }

            
            if !units.isEmpty {
                ScrollView{
                    LazyVStack{
                        ForEach(units, id:\.self){ _ in
                            
                          
                            AvailableFacilityCard(imageURL: "Imag", price: "800 SAR", name: "Blue Lagoon", address: "Al Qatif")
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                                .onTapGesture {
                                    willShowOfferPriceSetting.toggle()
                                }
                            
                        }
                    }
                }
            } else {
                Spacer()
                EmptyState(illustration: "empty_my_units", message: "You don`t have any published unit yet. Create your unit to make offers.")
                Spacer()
            }
                
        }
        
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChooseOfferFacility_Previews: PreviewProvider {
    static var previews: some View {
        ChooseOfferFacility()
    }
}
