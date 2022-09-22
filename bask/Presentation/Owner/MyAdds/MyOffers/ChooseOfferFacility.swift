//
//  ChooseOfferFacility.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct ChooseOfferFacility: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: MyOffersViewModel
    @State var units: [Int] = [1]
    @State var willShowOfferPriceSetting: Bool = false
    @Namespace private var animation

    
    var body: some View {
        
        ZStack {
            
            if willShowOfferPriceSetting {
                OfferPriceSettingScreen(facility: model.selectedFacility, animation: animation, isShown: $willShowOfferPriceSetting)
                    
            }
            
            else {
                VStack(alignment: .leading) {
                    
                    //MARK: - Back button
                    BackButton(onTap: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
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
                    
    //                NavigationLink(isActive: $willShowOfferPriceSetting) {
    //                    OfferPriceSettingScreen(facility: offerFacility, animation: animation)
    //                } label: {
    //                    EmptyView()
    //                }

                    
                    if !model.facilities.isEmpty {
                        ScrollView{
                            LazyVStack{
                                ForEach(model.facilities){ facility in
                                    
                                  
                                    AvailableFacilityCard(imageURL: "dummy.url", price: facility.price, name: facility.name, address: facility.address)
                                        .matchedGeometryEffect(id: facility.id, in: animation, anchor: .bottom)
                                        .frame(height: UIScreen.main.bounds.height * 0.15)
                                        .padding()
                                        .onTapGesture {
                                            
                                            withAnimation(.easeInOut){
                                                willShowOfferPriceSetting.toggle()
                                                model.selectedFacility = facility

                                                
                                            }
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
                .opacity(willShowOfferPriceSetting ? 0 : 1)
                .navigationBarHidden(true)
                //.navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    model.getFacilities()
            }
            }
        }
    }
}

//struct ChooseOfferFacility_Previews: PreviewProvider {
//    static var previews: some View {
//        ChooseOfferFacility()
//    }
//}
