//
//  BookedFacilitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct BookedFacilitiesScreen: View {
    //@EnvironmentObject var viewModel: MyUnitsViewModel
    //@StateObject var viewModel = MyUnitsViewModel()
    @StateObject var model = BookedFacilitiesListViewModel()
    @State var bookedFacilities: [Int] = [1]
    
    init(){
        print("Init --->: BookedFacilitiesScreen")
    }
    
    
    var body: some View {
        
        switch model.state {
        case .loading:
            Spinner()
        case .success:
            if model.facilities.isEmpty {
                
                EmptyState(illustration: "empty_my_units", message: "You don't have a booking yet.")
                
            } else {
                ScrollView{
                    LazyVStack(alignment: .leading){
                        ForEach(model.facilities) { facility in
                            
                            NavigationLink {
                                FacilityDetailScreen(style: .booked)
                            } label: {
                                BookedFacilityCard(bookingDates: facility.bookedDates, name: facility.description,
                                    imgURL: facility.imgURL,
                                    address: facility.address)
                                
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

struct BookedFacilitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        BookedFacilitiesScreen()
    }
}


struct BookedFacilityCard: View {
    
    let bookingDates: String
    let name: String
    let imgURL: String
    let address: String
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 2)
                
                HStack(alignment: .top){
                    
                    ImageView(withURL: imgURL, size: CGSize(width: geometry.size.width * 0.40, height: geometry.size.height))
                        .frame(width: geometry.size.width * 0.40, height: geometry.size.height)
                        .cornerRadius(6)
                        .padding([.top, .leading, .bottom], 4)
                    
                    VStack(alignment: .leading){
                        Text(bookingDates)
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


