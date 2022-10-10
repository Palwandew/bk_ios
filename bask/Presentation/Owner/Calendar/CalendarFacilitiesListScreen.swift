//
//  CalendarFacilitiesListScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/10/2022.
//

import SwiftUI

struct CalendarFacilitiesListScreen: View {
    
    @StateObject var model = AvailableFacilitiesListViewModel()
    
    @State var facilities: [Int] = [1, 3]
    
    @State var startDate: Date? = nil
    @State var endDate: Date? = nil
    @State var showCalendar: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Group {
                Text("Facilities")
                    .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Text("Select your facility to check its calendar")
                    .font(.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                 
            }.padding(.horizontal)
            
            NavigationLink(isActive: $showCalendar) {
                //CalendarViews(startDate: $startDate, endDate: $endDate)
            } label: {
                EmptyView()
            }
            
            switch model.state {
            case .loading:
                Spinner()
            case .success:
                if model.facilities.isEmpty {
                    
                    EmptyState(illustration: "empty_my_units", message: "You don't have a published unit yet.")
                    
                } else {
                    ScrollView{
                        //VStack(alignment: .leading){
                            
                            
                            ForEach(model.facilities) { facility in
                                
                                AvailableFacilityCard(
                                    imageURL: facility.imgURL,
                                    price: facility.price,
                                    name: facility.name,
                                    address: facility.address)
                                    .frame(height: UIScreen.main.bounds.height * 0.15)
                                    .padding()
                                    .onTapGesture {
                                        showCalendar.toggle()
                                    }
                                
                            }
                    }.padding(.bottom, 4)
                    //}.background(Color(AppColor.BACKGROUND))
                }
                
            case .failed:
                ErrorStateScreen()
            case .initial:
                EmptyView()
            }
        }
        .background(Color(AppColor.BACKGROUND))
    }
}

struct CalendarFacilitiesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarFacilitiesListScreen()
    }
}
