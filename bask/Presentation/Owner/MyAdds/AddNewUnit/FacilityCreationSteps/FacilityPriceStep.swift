//
//  FacilityPriceStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/11/2022.
//

import SwiftUI

struct FacilityPriceStep: View {
    
    @ObservedObject var model: FacilityPriceViewModel
    @State var pricePerNight: String = ""
    @State var isValid: Bool = true
    var errorMessage: LocalizedStringKey = "valid_description"
    
    @State var showDescription: Bool = false
    
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            //MARK: - Price per night
            ScrollView(showsIndicators: false) {
                
                
                Text("Price per night")
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                    .padding(.bottom, 1)
                
                Text("Set up the price per night. This price will be the default, if you want to change the price for some days you can do it in the calendar.")
                    .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .padding(.bottom, 32)
                
                
                MaterialPriceField(text: $model.pricePerNight, isValid: $model.validPerNightPrice, errorMessage: errorMessage, placeHolder: "Price per night")
                
                
                //MARK: - Deposit
                
                Text("Deposit")
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.top)
                    .padding(.bottom, 1)
                
                Text("This amount will be withdrawn and frozen from the guest's account till the time you prove that everything is ok with your unit. Insurance is for all staying periods. Set deposit amount wise - big sum can influence on guest`s decision.")
                    .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    .padding(.bottom, 32)
                
                MaterialPriceField(text: $model.deposit, isValid: $model.validDepositPrice, errorMessage: errorMessage, placeHolder: "Deposit")
                
                Spacer()
            }
            
        }
        .background(Color.white)
        
    }
}

