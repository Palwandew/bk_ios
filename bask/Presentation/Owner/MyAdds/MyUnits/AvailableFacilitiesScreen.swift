//
//  AvailableFacilitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct AvailableFacilitiesScreen: View {
    //@EnvironmentObject var viewModel: MyUnitsViewModel
    @StateObject var viewModel = MyUnitsViewModel()
    @State var availableFacilities: [Int] = [5]
    var body: some View {
        
        switch viewModel.screenState {
        case .loading:
            Spinner()
        case .success:
            if availableFacilities.isEmpty {
                
                EmptyState(illustration: "empty_my_units", message: "You don't have a published unit yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0...availableFacilities.count, id:\.self) { _ in
                            
                            NavigationLink {
                                FacilityDetailScreen(style: .available)
                            } label: {
                                AvailableFacilityCard(price: "800 SAR", name: "Sunny House", address: "Uhud Road, Al-Qatif")
                                    .frame(height: UIScreen.main.bounds.height * 0.15)
                                    .padding()
                            }
                            
                        }
                    }
                }.background(Color.white)
            }
            
        case .failed:
            Text("error occured")
        case .initial:
            EmptyView()
        }
        
    }
}

struct AvailableFacilitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        AvailableFacilitiesScreen()
    }
}


struct AvailableFacilityCard: View {
    
    let price: String
    let name: String
    let address: String
    
    var body: some View {
        
        GeometryReader { geometry in
        ZStack{
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .shadow(radius: 2)
            
            HStack(alignment: .top){
                    Image("sample_resort")
                        .resizable()
                        .frame(width: geometry.size.width * 0.40, height: geometry.size.height)
                        .cornerRadius(6)
                        .padding([.top, .leading, .bottom], 4)
                                        
                    VStack(alignment: .leading){
                        Text(price)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        Spacer()
                        
                        Text(name)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .lineLimit(2)
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        Text(address)
                            .font(Font.custom("Poppins-Medium", size: 12, relativeTo: .callout))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            
                    }.padding(.top)
                    .padding(8)
                    Spacer()
                }
            }
        }
    }
}
