//
//  FacilityPriceSetupScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/08/2022.
//

import SwiftUI

struct FacilityPriceSetupScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332
    
    @State var checkInAfter: String = ""
    @State var checkInBefore: String = "02:00 PM"
    @State var checkOutBefore: String = ""
    
    // ppn
    @State var pricePerNight: String = ""
    @State var isValid: Bool = true
    var errorMessage: LocalizedStringKey = "valid_description"
    
    @State var showTimePicker: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Set up price")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Price per night")
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.top)
                .padding(.bottom, 1)
            
            Text("Set up the price per night. This price will be the default, if you want to change the price for some days you can do it in the calendar.")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 32)
            
            
            MaterialPriceField(text: $pricePerNight, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Price per night")
            
            Text("Deposit")
                .font(Font.custom("Poppins-Medium", size: 16, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.top)
                .padding(.bottom, 1)
            
            Text("This amount will be withdrawn and frozen from the guest's account till the time you prove that everything is ok with your unit. Insurance is for all staying periods. Set deposit amount wise - big sum can influence on guest`s decision")
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.bottom, 32)
            
            MaterialPriceField(text: $pricePerNight, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Deposit")
                
                Spacer()
                
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    print("tapped")
                    
                    
                }.padding(.top)
                    .background(Rectangle().fill(Color.white.opacity(0.5)))
                
                
        
            
        }
        .padding(.horizontal)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action : {
                    print("Back button tapped")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(AppColor.GREY))
                    
                },
            trailing: Button(action : {
                print("Back button tapped")
                self.presentationMode.wrappedValue.dismiss()
                //                    self.dismiss.callAsFunction()
            }){
                Text("Exit")
                    .font(Font.custom("Poppins-Light", size: 16.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                
            })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                HStack{
                    
                    LinearProgressBar(value: $progress)
                        .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/100)
                    
                }
            }
        }
    }
}

struct FacilityPriceSetupScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPriceSetupScreen()
    }
}
