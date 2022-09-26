//
//  FacilityPercentageScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI

struct FacilityPercentageScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var model: FacilityPercentagListViewModel = FacilityPercentagListViewModel(GetFacilityPercentagesUsecase(repo: FacilityRepositoryImpl()))
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Percentages")
                .font(.custom("Poppins-Medium", size: 26))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Percentages_subtitle")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            switch model.state {
                
            case .failed:
                ErrorStateScreen {
                    model.tryAgainToGetData()
                }
                
            case .loading:
                Spacer()
                HStack {
                    Spacer()
                    Spinner()
                    Spacer()
                }
                Spacer()
            case .success:
                if !model.facilityPercentages.isEmpty{
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 16){
                            
                            ForEach(model.facilityPercentages){ item in
                                
                                FacilityPercentageListItem(model: item)
                            }
                        }.padding(4)
                    }
                }
            case .initial:
                EmptyView()
            }
            
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button{
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct FacilityPercentageScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPercentageScreen()
        
        FacilityPercentageScreen().environment(\.locale, .init(identifier: "ar") )
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct FacilityPercentageListItem: View {
    
    let model: FacilityPercentageViewModel
    
    var body: some View {
        HStack{
            
            ImageView(withURL: model.photoURL, size: CGSize(width: 75, height: 65))
                .frame(width: 75, height: 65)
                .cornerRadius(6)
            
            Text(model.name)
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                .lineLimit(2)
            
            Spacer()
            
            Text("\(model.percentage)")
                .font(.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
        }
        .padding([.leading, .top, .bottom], 4)
        .padding(.trailing, 8)
        .background(Color.white.cornerRadius(8).shadow(radius: 4))
    }
}
