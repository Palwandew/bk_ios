//
//  PublishFacilityScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct PublishFacilityScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AddNewUnitViewModel
    //@StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    private var facilityName: String = "Shul-e-Yal"
    @State var progress: Float = 1
    @State var show: Bool = false
    @State var toastShow = false
    
    
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
            
            Text("Your facility “\(viewModel.facilityNameViewModel.englishName)” is ready to be published. You can change everything after publishing.")
                .multilineTextAlignment(.center)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top)
            
            
            
            //MARK: - Continue Button
            
//            NavigationLink(destination:
//                            FacilityPicturesScreen(), isActive: $show) {
//                EmptyView()
//            }.isDetailLink(false)
            
            Spacer()
            
            FilledButton(label: "Save Unpublished", color: Color(AppColor.LIGHT_VOILET)) {
                
                print("unpublished")
                //showPicturesScreen.toggle()
                viewModel.saveFacilityUnpublished()
                
            }.padding(.top)
        
                
                
            FilledButton(label: "Publish", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                //showPicturesScreen.toggle()
                
                viewModel.publishFacility()
                
            }.padding(.top)
                .background(Rectangle().fill(Color.white.opacity(0.5)))
            
            
            
            
        }
        .padding(.horizontal)
        .background(Color.white)
//        .toast(isShowing: $viewModel.showToast, content: {
//
//            switch viewModel.toastStyle {
//            case .failure:
//                Toast(message: "An error occured while publishing your ad. Please try again.", style: .failure)
//            case .success:
//                Toast(message: "Your ad has been published successfully.", style: .success)
//            }
//
//        })
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
            trailing:
                    Button{} label:{
                Text("Show ad")
                    .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.top)
            }
        )
    }
}

struct PublishFacilityScreen_Previews: PreviewProvider {
    static var previews: some View {
        PublishFacilityScreen()
    }
}
