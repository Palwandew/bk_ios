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
    @State var progress: Float = 0.083 // total 12 steps therefore each one is 0.083
    @State var arabicName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            
            
            //MARK: - Title
            
            Text("Name of the facility")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - English Name
            VStack(alignment: .trailing) {
                MaterialTextField(text: $addNewUnitViewModel.facility.englishName, isValid: $addNewUnitViewModel.isValidEnglishName, errorMessage: "Please enter a name", placeHolder: "Name").keyboardType(.default)
                
                Text("\(addNewUnitViewModel.facilityName.count) / 50")
                    .font(Font.custom("Poppins-Light", size: 12.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }
            
            //MARK: - Arabic Name
            
            VStack(alignment: .leading) {
                ArabicTextInputField(text: $addNewUnitViewModel.facility.arabicName)
                    .frame(height: 25)
                    .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(addNewUnitViewModel.isValidArabicName ? .gray : .red, lineWidth: 1))
                if !addNewUnitViewModel.isValidArabicName {
                    Text("Please enter Arabic name")
                        .foregroundColor(.red)
                        .font(Font.custom("Poppins-Light", size: 12.0, relativeTo: .caption))
                }
            }
            
            Spacer()
            
            
            //MARK: - Continue Button 
            NavigationLink(destination:
                            FacilityRoomsScreen().environmentObject(addNewUnitViewModel), isActive: $addNewUnitViewModel.willShowAddRoomsScreen) {
                    EmptyView()
                }
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
               
                addNewUnitViewModel.isFacilityNameValid()

                
            }
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
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
