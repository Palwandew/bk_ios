//
//  FacilityLocationStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/11/2022.
//

import SwiftUI

struct FacilityAddressStep: View {
    
    @ObservedObject var model: FacilityLocationViewModel
    private let errorMsg: LocalizedStringKey = LocalizedStringKey("error")
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("Before booking, guests can't see your exact address")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
            
            
            //ScrollView {
            
            //MARK: - Country
            
            MaterialTextSelector(text: $model.country, placeHolder: "Country")
                .frame(height: 55)
            
            
            //MARK: - City
            
            MaterialTextField(text: $model.city, isValid: $model.validCity, errorMessage: errorMsg, placeHolder: "City")
                .padding([.top, .horizontal], 1)
            
            //}
            
            //MARK: - Address
            
            MaterialTextField(text: $model.street, isValid: $model.validStreet, errorMessage: errorMsg, placeHolder: "Address")
                .padding([.top, .horizontal], 1)
            
            Spacer()
            
            
        }
//        .fullScreenCover(isPresented: $showCountries, content: {
//            CountriesListScreen()
//        })
        .background(Color.white)
        
    }
}

