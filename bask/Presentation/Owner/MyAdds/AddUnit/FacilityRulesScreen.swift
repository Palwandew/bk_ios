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
    
    var body: some View {
        //MARK: - Title
        
        VStack(alignment: .leading, spacing: 24){
            Text("Rules of house")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
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
                    
                    Toggle(isOn: $isPetsAllowed) {
                        Text("Rodents")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $isPetsAllowed) {
                        Text("Reptile")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $isPetsAllowed) {
                        Text("Big Animals")
                    }.toggleStyle(Checkbox())
                }
            }
            
            AmenityToggle(isOn: $isPetsAllowed, label: "Allowed to smoke")
            
            AmenityToggle(isOn: $isPetsAllowed, label: "Addtional rules")
            
            Spacer()
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
