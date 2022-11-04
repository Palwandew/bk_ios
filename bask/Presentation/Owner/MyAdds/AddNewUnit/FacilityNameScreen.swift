//
//  FacilityNameScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct FacilityNameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.1 // total 12 steps therefore each one is 0.083
    @State var arabicName: String = ""
    
    @State var englishNameError: Bool = false
    @State var arabicNameError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            
            
            //MARK: - Title
            
            Text("Name of the facility")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - English Name
            VStack(alignment: .trailing) {
                UIKitWrappedTextField(text: $addNewUnitViewModel.facilityNameViewModel.englishName, placeHolder: "English name", returnButton: .next, inputLanguageIdentifier: "en", tag: 1, error: $addNewUnitViewModel.facilityNameViewModel.englishNameError)
                
                Text("\(addNewUnitViewModel.facilityName.count) / 50")
                    .font(Font.custom("Poppins-Light", size: 12.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }
            
            //MARK: - Arabic Name
            
            VStack(alignment: .leading) {
                UIKitWrappedTextField(text: $addNewUnitViewModel.facilityNameViewModel.arabicName, placeHolder: "Arabic name", returnButton: .continue, inputLanguageIdentifier: "ar", tag: 2, error: $addNewUnitViewModel.facilityNameViewModel.arabicNameError)
                
            }
            
            Spacer()
            
            
            //MARK: - Continue Button 
            NavigationLink(destination:
                            FacilityRoomsScreen().environmentObject(addNewUnitViewModel), isActive: $addNewUnitViewModel.facilityNameViewModel.shallNavigate) {
                    EmptyView()
                }
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
               
                addNewUnitViewModel.isFacilityNameValid()

                
            }
            
        }
        .padding(.horizontal)
        .background(Color.white)
        .toast(isShowing: $addNewUnitViewModel.shallRetry, content: {
            Toast(message: "An error occured. Please try again.", style: .failure)
            
        })
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
                        .frame(width: UIScreen.main.bounds.width/2,height: (UIScreen.main.bounds.height * 1)/100)
                    
                }
            }
        }
    }
}

struct FacilityNameScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityNameScreen()
    }
}
