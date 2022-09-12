//
//  UnpublishedFacilitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct UnpublishedFacilitiesScreen: View {
    //@EnvironmentObject var viewModel: MyUnitsViewModel
    @StateObject var viewModel = MyUnitsViewModel()
    @State var availableFacilities: [Int] = [1]
    @State var progress: Float = 0.89
    
    init(){
        print("Init --->: unPubFacilitiesScreen")
    }
    var body: some View {
        
        switch viewModel.screenState {
        case .loading:
            Spinner()
        case .success:
            if availableFacilities.isEmpty {
                
                EmptyState(illustration: "empty_unpublished_units", message: "You have not added a unit yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(0...availableFacilities.count, id:\.self) { _ in
                            
                            
                            NavigationLink {
                                FacilityDetailScreen(style: .available)
                            } label: {
                                UnpublishedFacilityCard(name: "Sunny House", progress: $progress, address: "Uhud Road, Al-Qatif")
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

struct UnpublishedFacilitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        UnpublishedFacilitiesScreen()
    }
}


struct UnpublishedFacilityCard: View {
    

    let name: String
    @Binding var progress: Float
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
                                                
                        Text(name)
                            .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .body))
                            .lineLimit(2)
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        Spacer()
                        
                        HStack{
                            LinearProgressBar(value: $progress)
                                .frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/100)
                            
                            Spacer()
                            
                            Text("\(Int(progress * 100))%")
                                .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .callout))
                                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        }
                        
                        Spacer()
                        
                        Button {
                            print("continue tapped")
                        } label: {
                            HStack{
                                Text("Continue")
                                    .font(Font.custom("Poppins-Medium", size: 14, relativeTo: .callout))
                                
                                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                                
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            }
                        }


                        
                            
                    }.padding(.top)
                    .padding(8)
                    Spacer()
                }
            }
        }
    }
}
