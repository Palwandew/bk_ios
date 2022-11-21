//
//  FacilityDescriptionStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 21/11/2022.
//

import SwiftUI

struct FacilityDescriptionStep: View {
    @ObservedObject var model: FacilityDescriptionViewModel
    @State var description: String = ""
    @State var isValid: Bool = true 
    let errorMessage: LocalizedStringKey = "valid_description"
    @State var showPicturesScreen: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Describe the best sides of your facility.")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                
                .padding(.bottom, 32)
            
            
            MaterialTextField(text: $model.description, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Description (Optional)")
            
        }
        .background(Color.white)
    }
}

