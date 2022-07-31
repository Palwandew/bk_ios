//
//  CancellationPolicyScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct CancellationPolicyScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isChecked: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            //MARK: - Title
            
            Text("Cancellation policy")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Set up when facility booking can be canceled by a guest. These settings are applied to all facilities in your account.")
                .font(Font.custom("Poppins-Light", size: 14, relativeTo: .title))
                .fontWeight(.regular)
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            
            CancellationPolicyItem(checked: $isChecked, label: "Anytime", description: "User can cancel booking anytime without loosing money")
            
            CancellationPolicyItem(checked: $isChecked, label: "72 hours before booking time -20% of the booking price", description: "User can cancel for free until 72 hours before the booking time, then he should pay you 20 % of the price")
            
            CancellationPolicyItem(checked: $isChecked, label: "A week before booking time -20% of the booking price", description: "User can cancel for free untill a week before the booking time, then he should pay you 20 % of the price")
            
            Spacer()
            
        }
        .padding(.horizontal)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading:
                Button(action : {
                    print("Back button tapped")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(AppColor.GREY))
                    
                })
    }
}

struct CancellationPolicyScreen_Previews: PreviewProvider {
    static var previews: some View {
        CancellationPolicyScreen()
    }
}

struct CancellationPolicyItem: View {
    
    @Binding var checked: Bool
    let label: String
    let description: String

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(label)
                    .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                    .fontWeight(.regular)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Spacer()
                
                RadioButton(checked: $checked)
            }
            
            Text(description) .font(Font.custom("Poppins-Light", size: 14, relativeTo: .title))
                .fontWeight(.regular)
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
        }
    }
}
