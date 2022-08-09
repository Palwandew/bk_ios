//
//  PublishFacilityScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct PublishFacilityScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: Float = 1

    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Publish your ad")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            //MARK: - Illustration
            
            HStack {
                Spacer()
                
                Image("publish_add_illustration")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
            }
            
            
            //MARK: - Message
            
            Text("Your ad “Sunny appartment with swimming pool” is ready to be published. You can change everything after publishing ")
                .multilineTextAlignment(.center)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top)
            
            
            //MARK: - Continue Button
            
//            NavigationLink(destination:
//                            FacilityPicturesScreen(), isActive: $showPicturesScreen) {
//                EmptyView()
//            }
            
            Spacer()
            
            FilledButton(label: "Save Unpublished", color: Color(AppColor.LIGHT_VOILET)) {
                
                print("unpublished")
                //showPicturesScreen.toggle()
                
            }.padding(.top)
        
                
                
            FilledButton(label: "Publish", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //showPicturesScreen.toggle()
                
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

struct PublishFacilityScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublishFacilityScreen()
    }
}
