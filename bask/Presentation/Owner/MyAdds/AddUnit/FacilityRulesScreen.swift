//
//  FacilityRulesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct FacilityRulesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332
    @State var isPetsAllowed: Bool = true
    
    @State var text: String = ""
    @State var valid: Bool = true
    let errorMsg: LocalizedStringKey = "valid_description"
    
    
    @State var showLocation: Bool = false
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("Rules of house")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            ScrollView {
                AmenityToggle(isOn: $isPetsAllowed, label: "Pets")
                
                if isPetsAllowed {
                    Group {
                        Toggle(isOn: $isPetsAllowed) {
                            Text("All pets allowed")
                        }.toggleStyle(Checkbox())
                        
                        Toggle(isOn: $isPetsAllowed) {
                            Text("Cats")
                        }.toggleStyle(Checkbox())
                        
                        Toggle(isOn: $isPetsAllowed) {
                            Text("Dogs")
                        }.toggleStyle(Checkbox())
                        
                        VStack(alignment: .leading) {
                            Toggle(isOn: $isPetsAllowed) {
                                Text("Rodents")
                            }.toggleStyle(Checkbox())
                            
                            Text("Rabbits, hamsters, rats, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        VStack(alignment: .leading) {
                            Toggle(isOn: $isPetsAllowed) {
                                Text("Reptile")
                            }.toggleStyle(Checkbox())
                            
                            Text("Snakes, iguanas, chameleon, etc   ")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Toggle(isOn: $isPetsAllowed) {
                                Text("Big Animals")
                            }.toggleStyle(Checkbox())
                            
                            Text("Horses, camels, cows, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                    }
                }
                
                AmenityToggle(isOn: $isPetsAllowed, label: "Allowed to smoke")
                
                AmenityToggle(isOn: $isPetsAllowed, label: "Addtional rules")
                
                if isPetsAllowed {
                    MaterialTextField(text: $text, isValid: $valid, errorMessage: errorMsg, placeHolder: "Additional rules")
                        .padding(.horizontal, 1)
                }
                
                NavigationLink(destination:
                                FacilityLocationScreen(), isActive: $showLocation) {
                    EmptyView()
                }
            }
            
            //MARK: - Continue Button
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //showRules.toggle()
                showLocation.toggle()
                
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

struct FacilityRulesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityRulesScreen()
    }
}
