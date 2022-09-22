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
                .padding(.horizontal)
            
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
                .padding(.horizontal)
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
                            ForEach(model.offers){ item in
                                
                                
                                AvailableFacilityCard(imageURL: item.photoURL , price: item.price, name: item.name, address: item.address)
                                    .frame(height: UIScreen.main.bounds.height * 0.15)
                                    .padding()
                                    
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
        
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MyOffersScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        MyOffersScreen()
        
    }
}
