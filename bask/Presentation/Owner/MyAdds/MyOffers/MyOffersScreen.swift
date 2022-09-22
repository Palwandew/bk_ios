//
//  MyOffersScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 20/09/2022.
//

import SwiftUI

struct MyOffersScreen: View {
    
    @StateObject var model: MyOffersViewModel = MyOffersViewModel(useCase: OffersUsecase(repo: OffersRepositoryImpl()))
    @State var willShowChooseFacilities: Bool = false
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            Text("My Offers")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - Add Offer Button
            
            NavigationLink(isActive: $willShowChooseFacilities) {
                ChooseOfferFacility()
                    .environmentObject(model)
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
                .onTapGesture {
                    model.getFacilities()
                    willShowChooseFacilities.toggle()
                }
            }.isDetailLink(false )

            
            

            
            //MARK: - Offers List
            Spacer()
            switch model.state {
            case .loading:
                Spacer()
                HStack {
                    Spacer()
                    Spinner()
                    Spacer()
                }
                Spacer()
            case .success:
                if model.offers.isEmpty {
                    Spacer()
                    EmptyState(illustration: "empty_my_offers_illustration", message: "You don`t have offers yet. Create your offer ad to attract guests")
                    
                    Spacer()
                } else {
                    ScrollView{
                        LazyVStack{
                            ForEach(model.offers, id:\.self){ _ in
                                
                                
                                FacilityCard(price: "1600 SAR", name: "Sunny House", bookingDates: "Al Qatif", bannerText: "-400 SAR", bannerColor: Color(AppColor.LIGHT_VOILET))
                                    .frame(height: UIScreen.main.bounds.height * 0.15)
                                    .padding(4)
                                    .padding(.bottom, 8)
                            }
                        }
                    }
                }
            case .failed:
                HStack{
                    Spacer()
                ErrorStateScreen()
                    Spacer()
                }
            case .initial:
                EmptyView()
            }
            
            Spacer()
            
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
