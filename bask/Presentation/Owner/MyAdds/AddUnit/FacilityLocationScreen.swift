//
//  FacilityLocationScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct FacilityLocationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332
    @State var isPetsAllowed: Bool = true
    
    @State var text: String = ""
    @State var valid: Bool = true
    let errorMsg: LocalizedStringKey = "valid_description"
    
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("Facility location")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Before booking, users can't see your exact address")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
            
            
            //ScrollView {
            
            //MARK: - Country
            
            MaterialTextField(text: $text, isValid: $valid, errorMessage: errorMsg, placeHolder: "Country")
                .padding([.top, .horizontal], 1)
            
            
            //MARK: - City
            
            MaterialTextField(text: $text, isValid: $valid, errorMessage: errorMsg, placeHolder: "City")
                .padding([.top, .horizontal], 1)
            
            //}
            
            //MARK: - Street
            
            MaterialTextField(text: $text, isValid: $valid, errorMessage: errorMsg, placeHolder: "Address")
                .padding([.top, .horizontal], 1)
            
            Spacer()
            
            //MARK: - Continue Button
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //showRules.toggle()
                
                
            }//.padding(.top, -24)
            
            
        }.padding(.horizontal)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action : {
                        print("Back button tapped")
                        //self.dismiss.callAsFunction()
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

struct FacilityLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityLocationScreen()
    }
}
