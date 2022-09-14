//
//  UnpublishedFacilitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct UnpublishedFacilitiesScreen: View {
    //@EnvironmentObject var viewModel: MyUnitsViewModel
    @StateObject var model = UnpublishedFacilitiesListViewModel(repository: FacilityRepositoryImpl())
    @State var availableFacilities: [Int] = [1]
    @State var progress: Float = 0.89
    @State var willShowChecklistScreen: Bool = false
    
    init(){
        print("Init --->: unPubFacilitiesScreen")
    }
    var body: some View {
        
        switch model.state {
        case .loading:
            Spinner()
        case .success:
            if model.facilities.isEmpty {
                
                EmptyState(illustration: "empty_unpublished_units", message: "You have not added a unit yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        
                        NavigationLink(isActive: $willShowChecklistScreen) {
                            HomeScreen()
                        } label: {
                            EmptyView()
                        }
                        
                        
                        ForEach(model.facilities) { facility in
                            
                            
                            UnpublishedFacilityCard(photoURL: facility.imgURL, name: facility.name, progress: facility.progressPercent, progressNumber: facility.progressNumber)
                                .frame(height: UIScreen.main.bounds.height * 0.15)
                                .padding()
                            
                            //                            NavigationLink {
                            //                                FacilityDetailScreen(facility: <#BookedFacilityViewModel#>, style: .available)
                            //                            } label: {
                            //                                UnpublishedFacilityCard(name: "Sunny House", progress: $progress, address: "Uhud Road, Al-Qatif")
                            //                                    .frame(height: UIScreen.main.bounds.height * 0.15)
                            //                                    .padding()
                            //                            }
                            
                            
                            
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
    
    let photoURL: String
    let name: String
    let progress: String
    let progressNumber: Int
    
    @State var prog: Float = 50
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 2)
                
                HStack(alignment: .top){
                    
                    ImageView(withURL: photoURL, size: CGSize(width: geometry.size.width * 0.40, height: geometry.size.height))
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

                            FacilityCreationProgress(value: progressNumber)
                                .frame(width: UIScreen.main.bounds.width/3.5, height: UIScreen.main.bounds.height/100)
                            
                            Spacer()
                            
                            Text(progress)
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
                                
                                Image(systemName: "arrow.forward")
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

struct FacilityCreationProgress: View {
    let value: Int
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(AppColor.GREY))
                
                Rectangle().frame(width: geometry.size.width * CGFloat(value) / 100, height: geometry.size.height)
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
            }.cornerRadius(4.0)
        }
    }
}
