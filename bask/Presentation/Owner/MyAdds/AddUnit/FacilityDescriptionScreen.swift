//
//  FacilityDescriptionScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/08/2022.
//

import SwiftUI

struct FacilityDescriptionScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 0.332
    
    @State var description: String = ""
    @State var isValid: Bool = true 
    let errorMessage: LocalizedStringKey = "valid_description"
    @State var showPicturesScreen: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Describe your facility")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Describe the best sides of your facility.")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
                .padding(.bottom, 32)
            
            
            MaterialTextField(text: $description, isValid: $isValid, errorMessage: errorMessage, placeHolder: "Description (Optional)")
            
            
            //MARK: - Continue Button
            
            NavigationLink(destination:
                            FacilityPicturesScreen(), isActive: $showPicturesScreen) {
                EmptyView()
            }
                
                Spacer()
                
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    print("tapped")
                    showPicturesScreen.toggle()
                    
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

struct FacilityDescriptionScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityDescriptionScreen()
    }
}
